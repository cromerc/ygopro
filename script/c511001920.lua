--Take Flight
function c511001920.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001920.condition)
	e1:SetTarget(c511001920.target)
	e1:SetOperation(c511001920.activate)
	c:RegisterEffect(e1)
end
function c511001920.cfilter(c)
	return c:IsFaceup() and c:IsCode(7093411)
end
function c511001920.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001920.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511001920.filter(c)
	return c:IsSetCard(0x1034) and not c:IsCode(7093411) and c:IsAbleToHand()
end
function c511001920.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001920.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(c511001920.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,sg:GetCount(),0,0)
end
function c511001920.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511001920.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
end
