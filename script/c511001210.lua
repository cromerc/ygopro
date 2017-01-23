--Jammer Slime
function c511001210.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511001210.condition)
	e1:SetCost(c511001210.cost)
	e1:SetTarget(c511001210.target)
	e1:SetOperation(c511001210.activate)
	c:RegisterEffect(e1)
end
function c511001210.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and rp~=tp and Duel.IsChainNegatable(ev)
end
function c511001210.cfilter(c)
	return (c:IsSetCard(0x207) or c:IsCode(46821314) or c:IsCode(68638985) or c:IsCode(18914778) or c:IsCode(3918345) or c:IsCode(100000705) or c:IsCode(100000706) or c:IsCode(31709826)) 
		and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c511001210.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001210.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c511001210.cfilter,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c511001210.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c511001210.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
