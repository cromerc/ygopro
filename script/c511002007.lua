--Melodious Rhythm Change
function c511002007.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c511002007.target)
	e1:SetOperation(c511002007.activate)
	c:RegisterEffect(e1)
end
function c511002007.filter(c,e,tp)
	if not c:IsFaceup() or not c:IsSetCard(0x9b) or not c:IsAbleToHand() then return false end
	if c:IsControler(tp) then
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
	else
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
			and Duel.IsExistingMatchingCard(c511002007.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp)
	end
end
function c511002007.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511002007.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511002007.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c511002007.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511002007.spfilter(c,e,tp)
	return c:IsSetCard(0x9b) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002007.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		if Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_HAND)
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(tp,c511002007.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
