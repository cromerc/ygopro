--Ending Gravestone
function c511000764.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetHintTiming(0,TIMING_STANDBY_PHASE)
	e1:SetCondition(c511000764.condition)
	e1:SetTarget(c511000764.target)
	e1:SetOperation(c511000764.operation)
	c:RegisterEffect(e1)
end
function c511000764.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=1000 and Duel.GetLP(1-tp)<=1000
end
function c511000764.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_HAND,LOCATION_HAND,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0xe,0xe,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
end
function c511000764.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_HAND,LOCATION_HAND,nil)
	Duel.SendtoGrave(g,REASON_EFFECT)
end
