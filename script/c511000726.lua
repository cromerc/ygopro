--House of Sand
function c511000726.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DECKDES+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511000726.condition)
	e2:SetTarget(c511000726.target)
	e2:SetOperation(c511000726.operation)
	c:RegisterEffect(e2)
end
function c511000726.cfilter(c)
	return c:IsPreviousLocation(LOCATION_DECK)
end
function c511000726.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000726.cfilter,1,nil)
end
function c511000726.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,eg:GetFirst():GetControler(),3)
end
function c511000726.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoHand(e:GetHandler(),eg:GetFirst():GetControler(),REASON_EFFECT)
	Duel.BreakEffect()
	Duel.DiscardDeck(eg:GetFirst():GetControler(),3,REASON_EFFECT)
end
