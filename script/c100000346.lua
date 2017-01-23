--森の商人 ポン
function c100000346.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000346,0))
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c100000346.rettg)
	e1:SetOperation(c100000346.retop)
	c:RegisterEffect(e1)
end
function c100000346.filter(c)
	return c:IsType(TYPE_FIELD) and c:IsAbleToDeck()
	 and Duel.IsExistingMatchingCard(c100000346.filter2,c:GetControler(),LOCATION_DECK,0,1,c)
end
function c100000346.filter2(c)
	return c:IsType(TYPE_FIELD) and c:IsAbleToHand()
end
function c100000346.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000346.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c100000346.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c100000346.filter,tp,LOCATION_HAND,0,1,1,nil)
	local ct=g:GetFirst()
	Duel.SendtoDeck(g,nil,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local dg=Duel.SelectMatchingCard(tp,c100000346.filter2,tp,LOCATION_DECK,0,1,1,ct)
	Duel.SendtoHand(dg,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,dg)
end
