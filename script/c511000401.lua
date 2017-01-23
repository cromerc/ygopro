--Spy Attack
function c511000401.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)	
	e1:SetCost(c511000401.cost)	
	e1:SetTarget(c511000401.target)
	e1:SetOperation(c511000401.activate)
	c:RegisterEffect(e1)
end
function c511000401.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c511000401.filter(c)
	return c:IsFacedown()
end
function c511000401.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000401.cfilter,tp,LOCATION_HAND,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511000401.cfilter,tp,LOCATION_HAND,0,1,1,nil,tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511000401.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_SZONE) and c511000401.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000401.filter,tp,0,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,c511000401.filter,tp,0,LOCATION_SZONE,1,1,nil)
end
function c511000401.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFacedown() then
		Duel.ConfirmCards(tp,tc)
	end
end