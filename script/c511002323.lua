--Advent of the Goddess
function c511002323.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002323.condition)
	e1:SetCost(c511002323.cost)
	e1:SetTarget(c511002323.target)
	e1:SetOperation(c511002323.activate)
	c:RegisterEffect(e1)
end
function c511002323.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsRace(RACE_FAIRY)
end
function c511002323.filter(c,e,tp)
	return c:IsRace(RACE_FAIRY) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY) 
		and Duel.IsExistingMatchingCard(c511002323.costfilter,tp,LOCATION_GRAVE,0,4,c)
end
function c511002323.costfilter(c)
	return c:IsRace(RACE_FAIRY) and c:GetLevel()==1 and c:IsAbleToRemoveAsCost()
end
function c511002323.spfilter(c,e,tp)
	return c:IsRace(RACE_FAIRY) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511002323.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002323.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	local spg=Duel.GetMatchingGroup(c511002323.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,e,tp)
	local g
	local remchk=false
	while g==nil or not remchk do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		g=Duel.SelectMatchingCard(tp,c511002323.costfilter,tp,LOCATION_GRAVE,0,4,4,nil)
		spg:Sub(g)
		if spg:GetCount()>0 then
			remchk=true
		end
		spg:Merge(g)
	end
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511002323.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511002323.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511002323.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c511002323.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(92039899,0))
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
