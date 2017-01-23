--Ｓｐ－我が身を盾に
function c100100500.initial_effect(c)
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c100100500.condition)
	e1:SetCost(c100100500.cost)
	e1:SetTarget(c100100500.target)
	e1:SetOperation(c100100500.operation)
	c:RegisterEffect(e1)
end
function c100100500.cfilter(c)
	return c:IsOnField() and c:IsType(TYPE_MONSTER)
end
function c100100500.condition(e,tp,eg,ep,ev,re,r,rp)
	if tp==ep or not Duel.IsChainNegatable(ev) then return false end
	if not re:IsActiveType(TYPE_MONSTER) and not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	local td=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	return td and ex and tg~=nil and tc+tg:FilterCount(c100100500.cfilter,nil)-tg:GetCount()>0 and td:GetCounter(0x91)>1
end
function c100100500.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1500) end
	Duel.PayLPCost(tp,1500)
end
function c100100500.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c100100500.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
