--Dimension Reversion
function c511000913.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000913.target)
	e1:SetOperation(c511000913.activate)
	c:RegisterEffect(e1)
end
function c511000913.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c511000913.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000913.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil) end
	local sg=Duel.GetMatchingGroup(c511000913.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,sg,sg:GetCount(),PLAYER_ALL,LOCATION_REMOVED)
end
function c511000913.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511000913.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
end
