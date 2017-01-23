-- Eye Contact
-- scripted by: UnknownGuest
function c810000061.initial_effect(c)
	-- add to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(810000061,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c810000061.thtg)
	e1:SetOperation(c810000061.thop)
	c:RegisterEffect(e1)
end
function c810000061.tgfilter(c)
	return c:IsCode(810000058) and c:IsAbleToHand()
end
function c810000061.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:GetControler()==tp and c810000061.tgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c810000061.tgfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c810000061.tgfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c810000061.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
