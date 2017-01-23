--Dragon Gust
function c511000342.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511000342.condition)
	e1:SetTarget(c511000342.target)
	e1:SetOperation(c511000342.activate)
	c:RegisterEffect(e1)
end
function c511000342.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c511000342.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) and Duel.IsExistingMatchingCard(c511000342.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511000342.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c511000342.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
