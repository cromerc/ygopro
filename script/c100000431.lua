--バイ＝マーセの癇癪
function c100000431.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c100000431.condition)
	e1:SetTarget(c100000431.target)
	e1:SetOperation(c100000431.activate)
	c:RegisterEffect(e1)
end
function c100000431.cfilter(c)
	return c:IsPosition(POS_FACEUP) and c:IsSetCard(0x21)
end
function c100000431.condition(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp or not Duel.IsExistingMatchingCard(c100000431.cfilter,tp,LOCATION_MZONE,0,1,nil) then return false end
	return Duel.IsChainNegatable(ev) and re:IsActiveType(TYPE_MONSTER)
end
function c100000431.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c100000431.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
