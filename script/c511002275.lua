--Vindictive Spirits
function c511002275.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511002275.condition)
	e1:SetTarget(c511002275.target)
	e1:SetOperation(c511002275.activate)
	c:RegisterEffect(e1)
end
function c511002275.spfilter(c,tp)
	return c:GetSummonPlayer()==1-tp and c:IsPreviousLocation(LOCATION_GRAVE)
end
function c511002275.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002275.spfilter,1,nil,tp)
end
function c511002275.filter(c,e,tp)
	return c:IsRace(0x10000000) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511002275.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511002275.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511002275.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002275.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
