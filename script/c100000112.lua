--レッドアイズ・スピリッツ
function c100000112.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c100000112.target)
	e1:SetOperation(c100000112.activate)
	c:RegisterEffect(e1)
end
function c100000112.filter(c,id,e,tp)
	return c:IsReason(REASON_DESTROY) and c:GetTurnID()==id and c:IsSetCard(0x3b) 
	 and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c100000112.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c100000112.filter,tp,LOCATION_GRAVE,0,1,nil,Duel.GetTurnCount(),e,tp)) 
		or(Duel.GetLocationCount(1-tp,LOCATION_MZONE,1-tp)>0 and Duel.IsExistingMatchingCard(c100000112.filter,tp,0,LOCATION_GRAVE,1,nil,Duel.GetTurnCount(),e,tp)) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c100000112.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,Duel.GetTurnCount(),e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,tp,LOCATION_GRAVE)
end
function c100000112.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if tc:GetPreviousControler()~=tp then
			Duel.SpecialSummon(tc,0,1-tp,1-tp,true,false,POS_FACEUP)
		else 
			Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		end
	end
end
