--Gorgonic Ritual
function c511002583.initial_effect(c)
	--Special Summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_ACTIVATE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetCost(c511002583.cost)
	e3:SetTarget(c511002583.target)
	e3:SetOperation(c511002583.activate)
	c:RegisterEffect(e3)
end
function c511002583.filter(c,e,tp)
	return c:IsRace(RACE_ROCK) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002583.cfilter(c,e,tp)
	return c:IsRace(RACE_ROCK) and c:IsType(TYPE_XYZ) and c:IsAbleToRemoveAsCost() 
		and Duel.IsExistingMatchingCard(c511002583.filter,tp,LOCATION_GRAVE,0,2,c,e,tp)
end
function c511002583.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002583.cfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	local g=Duel.SelectMatchingCard(tp,c511002583.cfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511002583.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE)
end
function c511002583.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetMatchingGroup(c511002583.filter,tp,LOCATION_GRAVE,0,nil,e,tp)
	if g:GetCount()>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,2,2,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
