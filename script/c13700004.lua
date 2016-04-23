--Secret Technique of the Hermit Youkai
function c13700004.initial_effect(c)
	--Activate(effect)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_ACTIVATE)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCondition(c13700004.condition)
	e4:SetTarget(c13700004.target)
	e4:SetOperation(c13700004.activate)
	c:RegisterEffect(e4)
end
function c13700004.condition(e,tp,eg,ep,ev,re,r,rp)
	if c==nil then return true end
	local tp=c:GetControler()
	return re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)
	 and not Duel.IsExistingMatchingCard(c13700004.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c13700004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13700004.filter1,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c13700004.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c13700004.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x1374)
end

function c13700004.filter(c)
	if not c then return false end
	return c:IsFaceup() and not c:IsSetCard(0x1374)
end
