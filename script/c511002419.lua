--ドラゴン・目覚めの旋律
function c511002419.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002419.condition)
	e1:SetCost(c511002419.cost)
	e1:SetTarget(c511002419.target)
	e1:SetOperation(c511002419.activate)
	c:RegisterEffect(e1)
end
function c511002419.cfilter(c)
	return c:IsFaceup() and c:IsCode(17985575)
end
function c511002419.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511002419.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511002419.costfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c511002419.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002419.costfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c511002419.costfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c511002419.filter(c)
	return c:IsRace(RACE_DRAGON) and c:IsAbleToHand()
end
function c511002419.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002419.filter,tp,LOCATION_DECK,0,2,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_DECK)
end
function c511002419.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511002419.filter,tp,LOCATION_DECK,0,nil)
	if sg:GetCount()<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=sg:Select(tp,2,2,nil)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
