--Synchro Barrier Force
function c511000615.initial_effect(c)
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(c511000615.condition)
	e1:SetTarget(c511000615.target)
	e1:SetOperation(c511000615.operation)
	c:RegisterEffect(e1)
end
function c511000615.condition(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsChainNegatable(ev) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tc>0
end
function c511000615.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	local dam=Duel.GetMatchingGroupCount(c511000615.filter,tp,LOCATION_MZONE,0,nil)*500
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	if dam>0 then Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam) end
end
function c511000615.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c511000615.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dam=Duel.GetMatchingGroupCount(c511000615.filter,tp,LOCATION_MZONE,0,nil)*500
	Duel.Damage(p,dam,REASON_EFFECT)
end
