--標本の閲覧
function c100000531.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100000531.cost)
	e1:SetTarget(c100000531.target)
	e1:SetOperation(c100000531.activate)
	c:RegisterEffect(e1)
end
function c100000531.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c100000531.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000531.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100000531.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c100000531.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,0,LOCATION_DECK,1,nil) end
end
function c100000531.filter(c,rc,lv)
	return c:IsType(TYPE_MONSTER) and c:IsRace(rc) and c:GetLevel()==lv and c:IsAbleToGrave()
end
function c100000531.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,563)
	local rc=Duel.AnnounceRace(tp,1,0xffffff)
	Duel.Hint(HINT_SELECTMSG,tp,567)
	local lv=Duel.AnnounceNumber(tp,1,2,3,4,5,6,7,8,9,10,11,12)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(1-tp,c100000531.filter,1-tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,rc,lv)
	local tc=g:GetFirst()
	if tc then
		Duel.SendtoGrave(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(tp,tc)
	else
		local dg=Duel.GetFieldGroup(tp,0,LOCATION_DECK+LOCATION_HAND)
		Duel.ConfirmCards(tp,dg)
		Duel.ShuffleDeck(1-tp)
		Duel.ShuffleHand(1-tp)
	end
end
