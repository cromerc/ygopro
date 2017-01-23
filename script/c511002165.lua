--Cicada Force
function c511002165.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002165.condition)
	e1:SetTarget(c511002165.target)
	e1:SetOperation(c511002165.activate)
	c:RegisterEffect(e1)
end
function c511002165.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x217)
end
function c511002165.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) 
		and Duel.IsExistingMatchingCard(c511002165.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511002165.filter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c511002165.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002165.filter,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(c511002165.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c511002165.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511002165.filter,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(sg,REASON_EFFECT)
end
