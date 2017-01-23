--黒蠍　愛の悲劇
function c111203901.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c111203901.condition)
	e1:SetCost(c111203901.cost)
	e1:SetTarget(c111203901.target)
	e1:SetOperation(c111203901.activate)
	c:RegisterEffect(e1)
end
function c111203901.cfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c111203901.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c111203901.cfilter,tp,LOCATION_ONFIELD,0,1,nil,76922029)
		and Duel.IsExistingMatchingCard(c111203901.cfilter,tp,LOCATION_ONFIELD,0,1,nil,74153887)
end
function c111203901.costfilter(c)
	return c:IsCode(74153887) and c:IsAbleToGraveAsCost()
end
function c111203901.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c111203901.costfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local cg=Duel.SelectMatchingCard(tp,c111203901.costfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(cg,REASON_COST)
end
function c111203901.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c111203901.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(sg,REASON_EFFECT)
end
