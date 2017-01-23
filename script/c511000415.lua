--左腕の代償
function c511000415.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000415.cost)
	e1:SetTarget(c511000415.target)
	e1:SetOperation(c511000415.operation)
	c:RegisterEffect(e1)
end
function c511000415.cfilter(c)
	return not c:IsAbleToGraveAsCost()
end
function c511000415.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g1=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	g1:RemoveCard(e:GetHandler())
	if chk==0 then return g1:GetCount()>0 and not g1:IsExists(c511000415.cfilter,1,nil) end
	Duel.SendtoGrave(g1,REASON_COST)
end
function c511000415.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c511000415.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_DECK and chkc:GetControler()==tp and c511000415.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000415.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c511000415.filter,tp,LOCATION_DECK,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c511000415.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end