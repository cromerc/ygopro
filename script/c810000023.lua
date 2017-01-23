-- Labor Pain
-- scripted by: UnknownGuest
function c810000023.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	-- cost
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SUMMON_COST)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
	e2:SetTarget(c810000023.sumtg)
	e2:SetCost(c810000023.ccost)
	e2:SetOperation(c810000023.acop)
	c:RegisterEffect(e2)
end
function c810000023.sumtg(e,c)
	return c:IsType(TYPE_MONSTER)
end
function c810000023.ccost(e,c,tp)
	return Duel.CheckLPCost(tp,1000)
end
function c810000023.acop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PayLPCost(tp,1000)
end