--Ｖ（ブイ）コール
function c111009401.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c111009401.target)
	e1:SetOperation(c111009401.activate)
	c:RegisterEffect(e1)
end
function c111009401.filter(c)
	return (c:IsCode(51638941) or c:IsCode(33725002) or c:IsCode(66970002)
	or c:IsCode(111009402) or c:IsSetCard(0x41) or c:IsSetCard(0x5008)) and c:IsAbleToHand() and c:IsType(TYPE_MONSTER)
end
function c111009401.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c111009401.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c111009401.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c111009401.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
