--Commande Duel 23
function c95200023.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95200023.target)
	e1:SetOperation(c95200023.activate)
	c:RegisterEffect(e1)
end
function c95200023.filter(c)
	return c:IsFaceup() and c:GetLevel()==4 and c:IsAbleToHand()
end
function c95200023.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c95200023.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c95200023.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c95200023.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end
