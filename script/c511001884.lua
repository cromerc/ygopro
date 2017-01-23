--Space Gate
function c511001884.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511001884.negcon)
	e1:SetTarget(c511001884.negtg)
	e1:SetOperation(c511001884.negop)
	c:RegisterEffect(e1)
end
function c511001884.cfilter(c)
	return c:IsFaceup() and c:IsCode(1992816)
end
function c511001884.negcon(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_TRAP) and Duel.IsChainNegatable(ev) 
		and Duel.IsExistingMatchingCard(c511001884.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511001884.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c511001884.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
