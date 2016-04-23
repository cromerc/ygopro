--黒蠍　愛の悲劇
function c111203902.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c111203902.condition)
	e1:SetTarget(c111203902.target)
	e1:SetOperation(c111203902.activate)
	c:RegisterEffect(e1)
end
function c111203902.cfilter(c,code)
	return c:IsFaceup() and c:GetCode()==code
end
function c111203902.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c111203902.cfilter,tp,LOCATION_MZONE,0,1,nil,76922029)
	and Duel.IsExistingMatchingCard(c111203902.cfilter,tp,LOCATION_MZONE,0,1,nil,74153887)
	and Duel.IsExistingMatchingCard(c111203902.cfilter,tp,LOCATION_MZONE,0,1,nil,48768179)
	and Duel.IsExistingMatchingCard(c111203902.cfilter,tp,LOCATION_MZONE,0,1,nil,6967870)
	and Duel.IsExistingMatchingCard(c111203902.cfilter,tp,LOCATION_MZONE,0,1,nil,61587183)
end
function c111203902.filter(c)
	return c:IsFaceup() and c:IsAbleToHand(() and ( c:IsCode(76922029) or c:IsSetCard(0x1a) )
end
function c111203902.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c111203902.filter,tp,LOCATION_MZONE,0,1,nil) end
	local sg=Duel.GetMatchingGroup(c111203902.filter,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,sg:GetCount(),0,0)
end
function c111203902.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c111203902.filter,tp,LOCATION_MZONE,0,nil)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
end
