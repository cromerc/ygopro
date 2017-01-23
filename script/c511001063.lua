--Brain Reboot
function c511001063.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001063.condition)
	e1:SetTarget(c511001063.target)
	e1:SetOperation(c511001063.operation)
	c:RegisterEffect(e1)
end
function c511001063.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=1000
end
function c511001063.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c511001063.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,0,LOCATION_MZONE,nil)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
	local dg=sg:Filter(Card.IsLocation,nil,LOCATION_HAND)
	local sum=dg:GetSum(Card.GetLevel)
	Duel.Damage(1-tp,sum*500,REASON_EFFECT)
end
