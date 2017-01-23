--Destiny Draw
--Scripted by Edo9300
function c511004000.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)	
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCountLimit(1)
	e1:SetRange(0xff)
	e1:SetCondition(c511004000.con)
	e1:SetOperation(c511004000.op)
	c:RegisterEffect(e1)
	--Destiny Draw
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PREDRAW)
	e2:SetRange(LOCATION_REMOVED)
	e2:SetCountLimit(1,511004000+EFFECT_COUNT_CODE_DUEL)
	e2:SetCondition(c511004000.drcon)
	e2:SetTarget(c511004000.drtg)
	e2:SetOperation(c511004000.drop)
	c:RegisterEffect(e2)
	--protection
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EFFECT_CANNOT_TO_DECK) 
	c:RegisterEffect(e5)
	local e6=e3:Clone()
	e6:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	c:RegisterEffect(e6)
end
function c511004000.con(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnCount()==1
end
function c511004000.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_REMOVED,0,1,nil,511004000) then
		Duel.DisableShuffleCheck()
		Duel.SendtoDeck(c,nil,-2,REASON_RULE)
	else
		Duel.Remove(c,POS_FACEUP,REASON_RULE)
	end
	if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
end
function c511004000.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=Duel.GetLP(1-tp)/2 and Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_MZONE,0)==0
		and	Duel.GetFieldGroupCount(e:GetHandler():GetControler(),0,LOCATION_MZONE)>0
end
function c511004000.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.GetTurnPlayer()~=tp then return end
	if chk==0 then return true end
	local dt=Duel.GetDrawCount(tp)
	if dt~=0 then
		_replace_count=0
		_replace_max=dt
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_DRAW_COUNT)
		e1:SetTargetRange(1,0)
		e1:SetReset(RESET_PHASE+PHASE_DRAW)
		e1:SetValue(0)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511004000.drop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	_replace_count=_replace_count+1
	if _replace_count>_replace_max or not c:IsRelateToEffect(e) then return end
	local g1=Duel.GetMatchingGroup(nil,tp,LOCATION_DECK,0,nil)
	if g1:GetCount()>5 then
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_DECK,0,5,5,nil)
	while g:GetCount()>0 do
	local sg=g:RandomSelect(tp,1):GetFirst()
		Duel.MoveSequence(sg,0)
	g:RemoveCard(sg)
	end
	Duel.Draw(tp,1,REASON_RULE)
	Duel.ShuffleDeck(tp)
	else
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.MoveSequence(g:GetFirst(),0)
	Duel.Draw(tp,1,REASON_RULE)
	Duel.ShuffleDeck(tp)
	end
end
end