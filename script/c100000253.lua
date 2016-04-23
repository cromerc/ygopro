--レベル・コピー
function c100000253.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000253.sptg)
	e1:SetOperation(c100000253.spop)
	c:RegisterEffect(e1)
end
function c100000253.filter(c,e,tp)
	local code=c:GetCode()
	return c:IsFaceup() and c:IsSetCard(0x41) and c:IsLevelBelow(5)
	 and Duel.IsExistingMatchingCard(c100000253.filter2,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,code,e,tp)
end
function c100000253.filter2(c,code,e,tp)
	return c:GetCode()==code and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c100000253.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c100000253.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c100000253.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c100000253.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c100000253.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then		
		local g=Duel.SelectTarget(tp,c100000253.filter2,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,tc:GetCode(),e,tp)
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
