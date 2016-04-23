---Noble Knight Brothers
function c502001000.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetCondition(c502001000.atkcon)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(502001000,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c502001000.sptg)
	e2:SetOperation(c502001000.spop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(502001000,1))
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c502001000.drtg)
	e3:SetOperation(c502001000.drop)
	c:RegisterEffect(e3)
end
function c502001000.atkfilter(c)
	return c:IsFaceup()
	and c:IsSetCard(0x107a)
end
function c502001000.atkcon(e)
	local tp=e:GetHandlerPlayer()
	local g=Duel.GetMatchingGroup(c502001000.atkfilter,tp,LOCATION_MZONE,0,nil)
	return not (g:GetCount()==3
	and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==3)
end
function c502001000.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
	and c:IsSetCard(0x107a)
end
function c502001000.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsExistingMatchingCard(c502001000.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(tp,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end	
function c502001000.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>2 then ft=2 end
	local g=Duel.GetMatchingGroup(c502001000.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
	if g:GetCount()>0 then
		local tg=g:Select(tp,1,ft,nil)
		local sc=tg:GetFirst()
		while sc do
			Duel.SpecialSummonStep(sc,0,tp,tp,false,false,POS_FACEUP)
			--
			sc=tg:GetNext()
		end
		Duel.SpecialSummonComplete()
	end
	--
	local ge1=Effect.CreateEffect(c)
	ge1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	ge1:SetType(EFFECT_TYPE_FIELD)
	ge1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	ge1:SetTargetRange(1,0)
	ge1:SetTarget(c502001000.splimit)
	ge1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(ge1,tp)
end	
function c502001000.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x107a)
end
function c502001000.drfilter(c)
	return c:IsAbleToDeck()
	and (c:IsSetCard(0x107a) or c:IsSetCard(0x207a))
end
function c502001000.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingTarget(c502001000.drfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local g=Duel.SelectTarget(tp,c502001000.drfilter,tp,LOCATION_GRAVE,0,3,3,nil)
	Duel.SetOperationInfo(tp,CATEGORY_TODECK,g,g:GetCount(),tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(tp,CATEGORY_DRAW,nil,0,tp,1)
end	
function c502001000.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DisableShuffleCheck()
	local c=e:GetHandler()
	local tp=c:GetControler()
	local tg=Duel.GetChainInfo(tp,CHAININFO_TARGET_CARDS)
	local fg=tg:Filter(Card.IsRelateToEffect,nil,e)
	if fg:GetCount()==3 then
		Duel.SendtoDeck(fg,nil,0,REASON_EFFECT)
		local g=fg:Filter(Card.IsLocation,nil,LOCATION_DECK)
		if g:GetCount()==3 then
			Duel.ShuffleDeck(tp)
			Duel.BreakEffect()
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end	
