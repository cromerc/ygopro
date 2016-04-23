--Noble Knight Gwalchavad
function c804000081.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_CHANGE_TYPE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c804000081.eqcon1)
	e1:SetValue(TYPE_NORMAL+TYPE_MONSTER)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(804000081,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(c804000081.spcon)
	e2:SetCost(c804000081.cost)
	e2:SetTarget(c804000081.sptg)
	e2:SetOperation(c804000081.spop)
	c:RegisterEffect(e2)
end
function c804000081.eqcon1(e)
	local eg=e:GetHandler():GetEquipGroup()
	return not eg or not eg:IsExists(Card.IsSetCard,1,nil,0x207a)
end
function c804000081.eqcon2(e)
	local eg=e:GetHandler():GetEquipGroup()
	return eg and eg:IsExists(Card.IsSetCard,1,nil,0x207a)
end
function c804000081.spcon(e,tp,eg,ep,ev,re,r,rp)
	return c804000081.eqcon2(e)
end
function c804000081.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,804000081)==0 end
	Duel.RegisterFlagEffect(tp,804000081,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c804000081.spfilter(c)
	return c:IsSetCard(0x107a) and c:IsAbleToHand()
end
function c804000081.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c804000081.spfilter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c804000081.spfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c804000081.spfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c804000081.desfilter(c)
	return c:IsSetCard(0x207a) and c:IsFaceup() and c:IsType(TYPE_EQUIP)
end
function c804000081.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_HAND) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local dg=Duel.SelectMatchingCard(tp,c804000081.desfilter,tp,LOCATION_SZONE,0,1,1,nil)
		Duel.Destroy(dg,REASON_EFFECT)
	end
end