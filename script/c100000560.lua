--オレンジ・シャーマン
function c100000560.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetDescription(aux.Stringid(100000560,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c100000560.condition)
	e1:SetTarget(c100000560.target)
	e1:SetOperation(c100000560.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c100000560.cfilter(c,e,tp)
	return c:IsControler(tp) and c:IsFaceup() and c:IsType(TYPE_EFFECT) and (not e or c:IsRelateToEffect(e))
end
function c100000560.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c100000560.cfilter,1,nil,nil,1-tp)
		and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c100000560.filter(c,e,tp)
	return c:IsSetCard(0x309) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000560.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000560.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c100000560.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000560.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
