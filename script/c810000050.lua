-- Card Breaker (Anime)
-- scripted by: UnknownGuest
function c810000050.initial_effect(c)
	c:EnableReviveLimit()
	-- spsummon proc
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c810000050.spcon)
	e1:SetOperation(c810000050.spop)
	c:RegisterEffect(e1)
end
function c810000050.spfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c810000050.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c810000050.spfilter,c:GetControler(),LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c810000050.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c810000050.spfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.Destroy(g,REASON_COST)
end

