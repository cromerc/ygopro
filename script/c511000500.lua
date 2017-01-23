--Protection of the Elements
function c511000500.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511000500.condition)
	e1:SetCost(c511000500.cost)
	e1:SetTarget(c511000500.target)
	e1:SetOperation(c511000500.activate)
	c:RegisterEffect(e1)
end
function c511000500.cfilter(c)
	return c:IsSetCard(0x3008) and c:IsAbleToRemoveAsCost()
end
function c511000500.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000500.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511000500.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetFirst():IsFacedown() then
		Duel.Remove(g,POS_FACEDOWN,REASON_COST+REASON_TEMPORARY)
	else
		Duel.Remove(g,POS_FACEUP,REASON_COST+REASON_TEMPORARY)
	end
	e:SetLabelObject(g:GetFirst())
end
function c511000500.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c511000500.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c511000500.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
	local tc=e:GetLabelObject()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetLabelObject(tc)
	e1:SetCountLimit(1)
	e1:SetOperation(c511000500.retop)
	Duel.RegisterEffect(e1,tp)
end
function c511000500.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetLabelObject())
end
