--Magical Academy
--scripted by: UnknownGuest
function c810000095.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE+TIMING_SUMMON)
	e1:SetCost(c810000095.cost)
	e1:SetTarget(c810000095.target)
	e1:SetOperation(c810000095.activate)
	c:RegisterEffect(e1)
end
function c810000095.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,2,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,2,2,REASON_COST)
end
function c810000095.filter(c)
	return c:IsRace(RACE_SPELLCASTER) and c:IsSummonable(true,nil)
end
function c810000095.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c810000095.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c810000095.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g=Duel.SelectMatchingCard(tp,c810000095.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
		local g=Duel.SelectMatchingCard(tp,c810000095.filter,tp,LOCATION_HAND,0,1,1,nil)
		Duel.Summon(tp,g:GetFirst(),true,nil)
		--[[Duel.SpecialSummonStep(tc,SUMMON_TYPE_NORMAL,tp,tp,false,false,POS_FACEUP)]]--
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(2)
		e1:SetReset(RESET_EVENT+0xfe0000)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(500)
		tc:RegisterEffect(e2)
		--disable
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetCode(EFFECT_DISABLE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
		e3:SetTarget(c810000095.distg)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
		--disable effect
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e4:SetCode(EVENT_CHAIN_SOLVING)
		e4:SetRange(LOCATION_MZONE)
		e4:SetOperation(c810000095.disop)
		e4:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e4)
		--disable effect
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e5:SetCode(EVENT_CHAINING)
		e5:SetRange(LOCATION_MZONE)
		e5:SetOperation(c810000095.disop)
		e5:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e5)
	end
end
function c810000095.distg(e,c,tp)
	return c:GetCardTargetCount()>0 and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:GetControler(1-tp)
end
function c810000095.disop(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and re:GetHandler():GetControler(1-tp) then return end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	Duel.NegateEffect(ev)
end
