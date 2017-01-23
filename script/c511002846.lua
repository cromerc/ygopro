--調律
function c511002846.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002846.target)
	e1:SetOperation(c511002846.activate)
	c:RegisterEffect(e1)
end
function c511002846.filter(c,tp)
	return c:IsType(TYPE_TUNER) and c:IsAbleToHand() and Duel.IsPlayerCanDiscardDeck(tp,c:GetLevel()+1)
end
function c511002846.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002846.filter,tp,LOCATION_DECK,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511002846.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511002846.filter,tp,LOCATION_DECK,0,1,1,nil,tp)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.ShuffleDeck(tp)
		Duel.BreakEffect()
		Duel.DiscardDeck(tp,g:GetFirst():GetLevel(),REASON_EFFECT)
	end
end
