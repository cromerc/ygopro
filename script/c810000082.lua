--Giant Flood
--scripted by: UnknownGuest
function c810000082.initial_effect(c)
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c810000082.condition)
	e1:SetTarget(c810000082.target)
	e1:SetOperation(c810000082.activate)
	c:RegisterEffect(e1)
end
function c810000082.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c810000082.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c810000082.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c810000082.cfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,LOCATION_ONFIELD+LOCATION_HAND,1,nil) end
	local sg=Duel.GetMatchingGroup(c810000082.cfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,LOCATION_ONFIELD+LOCATION_HAND,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,sg,sg:GetCount(),0,0)
end
function c810000082.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c810000082.cfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,LOCATION_ONFIELD+LOCATION_HAND,nil)
	Duel.SendtoGrave(sg,REASON_EFFECT)
end
