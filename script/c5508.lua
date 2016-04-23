--黒・魔・導・爆・裂・破
function c5508.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c5508.condition)
	e1:SetTarget(c5508.target)
	e1:SetOperation(c5508.activate)
	c:RegisterEffect(e1)
end
function c5508.cfilter(c)
	return c:IsFaceup() and (c:IsCode(38033121) or c:IsCode(90960358) or c:IsCode(43892408))
end
function c5508.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c5508.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c5508.filter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c5508.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c5508.filter,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(c5508.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c5508.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c5508.filter,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(sg,REASON_EFFECT)
end
