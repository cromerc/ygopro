--Virus Cannon (Anime)
function c513000000.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c513000000.target)
	e1:SetOperation(c513000000.operation)
	c:RegisterEffect(e1)
end
function c513000000.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToGrave()
end
function c513000000.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,0,LOCATION_DECK+LOCATION_HAND,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,10,tp,LOCATION_DECK)
end
function c513000000.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c513000000.filter,tp,0,LOCATION_DECK+LOCATION_HAND,nil):Select(1-tp,10,10,nil)
	Duel.SendtoGrave(g,REASON_EFFECT)
	if g:GetCount()<10 then
		local cg=Duel.GetFieldGroup(1-tp,LOCATION_DECK+LOCATION_HAND,0)
		Duel.ConfirmCards(tp,cg)
		Duel.ShuffleHand(1-tp)
		Duel.ShuffleDeck(1-tp)
	end
end
