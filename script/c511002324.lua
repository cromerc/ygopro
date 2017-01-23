--Angel Tear
function c511002324.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511002324.cost)
	e1:SetTarget(c511002324.target)
	e1:SetOperation(c511002324.activate)
	c:RegisterEffect(e1)
end
function c511002324.filter(c,e,tp)
	return c:IsRace(RACE_FAIRY) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY) 
		and Duel.IsExistingMatchingCard(c511002324.costfilter,tp,LOCATION_GRAVE,0,4,c)
end
function c511002324.costfilter(c)
	return c:IsRace(RACE_FAIRY) and c:IsAbleToRemoveAsCost()
end
function c511002324.spfilter(c,e,tp)
	return c:IsRace(RACE_FAIRY) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511002324.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002324.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	local spg=Duel.GetMatchingGroup(c511002324.spfilter,tp,LOCATION_GRAVE,0,nil,e,tp)
	local g
	local remchk=false
	while g==nil or not remchk do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		g=Duel.SelectMatchingCard(tp,c511002324.costfilter,tp,LOCATION_GRAVE,0,4,4,nil)
		spg:Sub(g)
		if spg:GetCount()>0 then
			remchk=true
		end
		spg:Merge(g)
	end
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511002324.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511002324.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511002324.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002324.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
