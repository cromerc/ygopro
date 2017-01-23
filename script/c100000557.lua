--未来への希望
function c100000557.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100000557.condition)
	e1:SetCost(c100000557.cost)
	e1:SetTarget(c100000557.target)
	e1:SetOperation(c100000557.activate)
	c:RegisterEffect(e1)
end
function c100000557.cfilter(c)
	return c:IsCode(89943723) and c:IsFaceup()
end
function c100000557.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000557.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c100000557.costfilter(c)
	return c:IsCode(24094653) and c:IsDiscardable()
end
function c100000557.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000557.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c100000557.costfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c100000557.filter1(c,tp)
	if not c:IsAbleToGrave() then return false end
	return Duel.IsExistingMatchingCard(c100000557.filter2,tp,LOCATION_EXTRA,0,1,nil,c)
end
function c100000557.filter2(c,mc)
	return c.material and mc:IsCode(table.unpack(c.material)) and c:IsSetCard(0x9)
end
function c100000557.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000557.filter1,tp,LOCATION_DECK,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c100000557.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c100000557.filter1,tp,LOCATION_DECK,0,nil,tp)
	Duel.SendtoGrave(g,REASON_EFFECT)
end
