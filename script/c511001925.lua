--Anchor Bind
function c511001925.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001925.condition)
	e1:SetTarget(c511001925.target)
	e1:SetOperation(c511001925.activate)
	c:RegisterEffect(e1)
end
function c511001925.cfilter(c)
	return c:IsFaceup() and c:IsCode(22702055)
end
function c511001925.check()
	return Duel.IsExistingMatchingCard(c511001925.cfilter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.IsEnvironment(22702055)
end
function c511001925.condition(e,tp,eg,ep,ev,re,r,rp)
	return c511001925.check()
end
function c511001925.filter(c)
	return c:IsPosition(POS_FACEUP_DEFENSE) and c:IsAttribute(ATTRIBUTE_FIRE) and c:IsDestructable()
end
function c511001925.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001925.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c511001925.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511001925.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511001925.filter,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
