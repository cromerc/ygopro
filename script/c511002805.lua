--Cornfused
function c511002805.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511002805.condition)
	e1:SetTarget(c511002805.target)
	e1:SetOperation(c511002805.activate)
	c:RegisterEffect(e1)
end
function c511002805.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and re:IsActiveType(TYPE_EFFECT) and Duel.IsChainDisablable(ev)
end
function c511002805.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c511002805.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
