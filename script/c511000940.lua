--Mirror Call
function c511000940.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000940.condition)
	e1:SetTarget(c511000940.target)
	e1:SetOperation(c511000940.activate)
	c:RegisterEffect(e1)
end
function c511000940.cfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c511000940.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000940.cfilter,tp,LOCATION_ONFIELD,0,1,nil,511000936)
		and Duel.IsExistingMatchingCard(c511000940.cfilter,tp,LOCATION_ONFIELD,0,1,nil,511000937)
end
function c511000940.filter(c)
	return c:IsType(TYPE_TRAP) and c:IsAbleToHand()
end
function c511000940.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_GRAVE and chkc:GetControler()==tp and c511000940.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000940.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c511000940.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c511000940.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
