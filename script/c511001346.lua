--Raptor's Storm
function c511001346.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(c511001346.condition)
	e1:SetTarget(c511001346.target)
	e1:SetOperation(c511001346.activate)
	c:RegisterEffect(e1)
end
function c511001346.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xba)
end
function c511001346.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) and rp~=tp 
		and Duel.IsExistingMatchingCard(c511001346.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511001346.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if re:GetHandler():IsRelateToEffect(re) and re:GetHandler():IsDestructable() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,re:GetHandler(),1,0,0)
	end
end
function c511001346.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(re:GetHandler(),REASON_EFFECT)
	end
end
