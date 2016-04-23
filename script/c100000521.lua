--フォーム・チェンジ
function c100000521.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000521.target)
	e1:SetOperation(c100000521.activate)
	c:RegisterEffect(e1)
end
function c100000521.tfilter(c,lv,e,tp)
	return c:IsSetCard(0xa008) and c:GetLevel()==lv and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c100000521.filter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0xa008) and c:IsAbleToExtra()
		and Duel.IsExistingMatchingCard(c100000521.tfilter,tp,LOCATION_EXTRA,0,1,nil,c:GetLevel(),e,tp)
end
function c100000521.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c100000521.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c100000521.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c100000521.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c100000521.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local lv=tc:GetLevel()
	if Duel.SendtoDeck(tc,tp,0,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c100000521.tfilter,tp,LOCATION_EXTRA,0,1,1,nil,lv,e,tp)
	if sg:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SpecialSummon(sg,0,tp,tp,true,false,POS_FACEUP)
		sg:GetFirst():CompleteProcedure()
	end
end
