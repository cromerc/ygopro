--Action Card - Heat up Sound
function c95000155.initial_effect(c)
	--negation prevention
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95000155,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c95000155.activate1)
	c:RegisterEffect(e1)
	--destroy prevention
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(95000155,1))
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetOperation(c95000155.activate2)
	c:RegisterEffect(e2)
	--act in hand
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e3:SetCondition(c95000155.handcon)
	c:RegisterEffect(e3)
end
function c95000155.handcon(e)
	return tp~=Duel.GetTurnPlayer()
end
function c95000155.activate1(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c95000155.condition1)
	e1:SetTarget(c95000155.target)
	e1:SetOperation(c95000155.operation)
	e1:SetCountLimit(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c95000155.condition1(e,tp,eg,ep,ev,re,r,rp)
	if tp==ep or not Duel.IsChainNegatable(ev) then return false end
	if not re:IsActiveType(TYPE_SPELL) and not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_NEGATE)
	return ex and tg~=nil and tc+tg:FilterCount(c95000155.cfilter,nil)-tg:GetCount()>0
end
function c95000155.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end

function c95000155.activate2(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c95000155.condition2)
	e1:SetTarget(c95000155.target)
	e1:SetOperation(c95000155.operation)
	e1:SetCountLimit(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c95000155.condition2(e,tp,eg,ep,ev,re,r,rp)
	if tp==ep or not Duel.IsChainNegatable(ev) then return false end
	if not re:IsActiveType(TYPE_SPELL) and not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tc+tg:FilterCount(c95000155.cfilter,nil)-tg:GetCount()>0
end
function c95000155.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c95000155.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end

