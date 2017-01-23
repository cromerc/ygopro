--Shovelroid
function c511002241.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6320631,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCost(c511002241.cost)
	e1:SetTarget(c511002241.target)
	e1:SetOperation(c511002241.operation)
	c:RegisterEffect(e1)
end
function c511002241.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c511002241.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c511002241.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511002241.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511002241.filter,tp,LOCATION_DECK,0,1,1,nil)
	local ct=Duel.GetMatchingGroupCount(Card.IsAbleToHand,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	elseif ct>0 then
		local cg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
		Duel.ConfirmCards(1-tp,cg)
		Duel.ConfirmCards(tp,cg)
		Duel.ShuffleDeck(tp)
	end
end
