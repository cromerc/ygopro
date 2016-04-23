--Raid Raptors - Nest
function c51370059.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetTarget(c51370059.target)
	e2:SetOperation(c51370059.operation)
	c:RegisterEffect(e2)
end
function c51370059.cfilter(c,tp)
	return c:IsFaceup() and Duel.IsExistingMatchingCard(c51370059.cfilter2,tp,LOCATION_MZONE,0,1,c,c:GetCode())
	and (c:IsCode(51370044) or c:IsCode(51370056))
end
function c51370059.cfilter2(c,code)
	return c:IsFaceup() and c:GetCode()==code
end
function c51370059.filter2(c,code,e,tp)
	return c:IsCode(code)
end
function c51370059.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c51370059.cfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c51370059.cfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c51370059.cfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c51370059.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=Duel.SelectMatchingCard(tp,c51370059.filter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,tc:GetCode(),e,tp)
		if sg:GetCount()>0 then
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
		end
	end
end
