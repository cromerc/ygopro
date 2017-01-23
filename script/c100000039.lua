--ゴースト・コンバート
function c100000039.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c100000039.condition)
	e1:SetCost(c100000039.cost)
	e1:SetTarget(c100000039.target)
	e1:SetOperation(c100000039.activate)
	c:RegisterEffect(e1)
end
function c100000039.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x3013)
end
function c100000039.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000039.cfilter,tp,LOCATION_MZONE,0,1,nil) and rp~=tp 
end
function c100000039.costfilter1(c)
	return c:IsRace(RACE_MACHINE) and c:IsFaceup() and c:IsAbleToRemoveAsCost()
end
function c100000039.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000039.costfilter1,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOREMOVE)
	local g=Duel.SelectMatchingCard(tp,c100000039.costfilter1,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c100000039.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c100000039.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsCanTurnSet() and e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		Duel.BreakEffect()
		c:CancelToGrave()
		Duel.ChangePosition(c,POS_FACEDOWN)
		Duel.RaiseEvent(c,EVENT_SSET,e,REASON_EFFECT,tp,tp,0)
	end
end
