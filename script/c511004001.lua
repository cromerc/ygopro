--Speed Duel
--Scripted by Edo9300
function c511004001.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)	
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCountLimit(1)
	e1:SetRange(0xff)
	e1:SetCondition(c511004001.con)
	e1:SetOperation(c511004001.op)
	c:RegisterEffect(e1)
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
function c511004001.con(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnCount()==1
end
function c511004001.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_REMOVED,0,1,nil,511004001) then
		Duel.DisableShuffleCheck()
		Duel.SendtoDeck(c,nil,-2,REASON_RULE)
	else
		Duel.Remove(c,POS_FACEUP,REASON_RULE)
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
		local g1=Duel.GetMatchingGroup(nil,tp,LOCATION_DECK,0,nil)
		if g1:GetCount()>20 then
		local tg1=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_DECK,0,g1:GetCount()-20,g1:GetCount()-20,nil)
		Duel.SendtoDeck(tg1,nil,-2,REASON_RULE)
		end
		local g2=Duel.GetMatchingGroup(nil,1-tp,LOCATION_DECK,0,nil)
		if g2:GetCount()>20 then
		local tg2=Duel.SelectMatchingCard(1-tp,nil,1-tp,LOCATION_DECK,0,g2:GetCount()-20,g2:GetCount()-20,nil)
		Duel.SendtoDeck(tg2,nil,-2,REASON_RULE)
		end
		local g3=Duel.GetMatchingGroup(nil,tp,LOCATION_EXTRA,0,nil)
		if g3:GetCount()>5 then
		local tg3=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_EXTRA,0,g3:GetCount()-5,g3:GetCount(),nil)
		Duel.SendtoDeck(tg3,nil,-2,REASON_RULE)
		end
		local g4=Duel.GetMatchingGroup(nil,1-tp,LOCATION_EXTRA,0,nil)
		if g4:GetCount()>5 then
		local tg4=Duel.SelectMatchingCard(1-tp,nil,1-tp,LOCATION_EXTRA,0,g4:GetCount()-5,g4:GetCount(),nil)
		Duel.SendtoDeck(tg4,nil,-2,REASON_RULE)
		end
		Duel.ShuffleDeck(tp)
		Duel.ShuffleDeck(1-tp)
		Duel.BreakEffect()
		Duel.Draw(tp,4,REASON_RULE)
		Duel.Draw(1-tp,4,REASON_RULE)
		local seq=-4
		while seq~=28 do
		seq=seq+4
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_DISABLE_FIELD)
		e1:SetLabel(seq)
		e1:SetOperation(c511004001.disop)
		e1:SetReset(0)
		Duel.RegisterEffect(e1,tp)
		end
	end
end
function c511004001.disop(e,tp)
	return bit.lshift(0x1,e:GetLabel())
end