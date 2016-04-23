--出幻
function c100000502.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c100000502.condition)
	e1:SetTarget(c100000502.target)
	e1:SetOperation(c100000502.operation)
	c:RegisterEffect(e1)
end
function c100000502.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsSetCard(0x5008) and c:IsType(TYPE_MONSTER)
end
function c100000502.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c100000502.cfilter,1,nil,tp)
end
function c100000502.spfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(0x5008) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000502.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000502.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c100000502.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000502.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		Duel.SpecialSummonComplete()
	end
end
