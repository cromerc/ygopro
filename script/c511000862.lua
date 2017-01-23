--Stay Force
function c511000862.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCost(c511000862.cost)
	e2:SetCondition(c511000862.condition)
	e2:SetTarget(c511000862.target)
	e2:SetOperation(c511000862.activate)
	c:RegisterEffect(e2)
end
function c511000862.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c511000862.condition(e,tp,eg,ep,ev,re,r,rp)
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TODECK)
	return Duel.GetCurrentPhase()==PHASE_END and re:IsActiveType(TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ) and ((ex and tg~=nil 
		and tg:IsContains(re:GetHandler())) or (re:GetHandler():IsCode(67030233) or re:GetHandler():IsCode(7841112))) and Duel.IsChainDisablable(ev)
end
function c511000862.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c511000862.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
