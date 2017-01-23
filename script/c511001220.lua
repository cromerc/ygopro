--Spell Spice Garmasala
function c511001220.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001220.target)
	e1:SetOperation(c511001220.activate)
	c:RegisterEffect(e1)
end
function c511001220.filter(c)
	return c:IsSetCard(0x1208) and c:IsAbleToHand()
end
function c511001220.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001220.filter,tp,LOCATION_DECK,0,3,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,3,tp,LOCATION_DECK)
end
function c511001220.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511001220.filter,tp,LOCATION_DECK,0,3,3,nil)
	if g:GetCount()>2 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
