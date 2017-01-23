--コピーキャット
function c511001136.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)	
	e1:SetCost(c511001136.cost)	
	e1:SetTarget(c511001136.target)
	e1:SetOperation(c511001136.activate)
	c:RegisterEffect(e1)
end
function c511001136.cfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToGraveAsCost()
end
function c511001136.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_DECK,0,5,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemoveAsCost,tp,LOCATION_DECK,0,5,5,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511001136.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(Card.IsExistingMatchingCard,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,0)
end
function c511001136.activate(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=Duel.SelectMatchingCard(tp,c511001136.tgfilter,tp,0,LOCATION_GRAVE,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
