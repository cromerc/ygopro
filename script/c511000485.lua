--Spy Hero
function c511000485.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000485.cost)
	e1:SetTarget(c511000485.target)
	e1:SetOperation(c511000485.activate)
	c:RegisterEffect(e1)
end
function c511000485.cfilter(c)
	return c:IsAbleToGrave()
end
function c511000485.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000485.cfilter,tp,LOCATION_DECK,0,2,nil) end
	local g=Duel.GetMatchingGroup(c511000485.cfilter,tp,LOCATION_DECK,0,nil):RandomSelect(tp,2)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511000485.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c511000485.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:GetLocation()==LOCATION_GRAVE and chkc:GetControler()~=tp and c511000485.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000485.filter,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c511000485.filter,tp,0,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c511000485.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetLabelObject(tc)
		e1:SetOperation(c511000485.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511000485.retop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc and tc:IsLocation(LOCATION_HAND+LOCATION_SZONE) and tc:IsControler(tp) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(tp,tc)
	end
end
