--Turf
function c511002661.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511002661.condition)
	e1:SetCost(c511002661.cost)
	e1:SetTarget(c511002661.target)
	e1:SetOperation(c511002661.activate)
	c:RegisterEffect(e1)
end
function c511002661.cfilter(c,tp)
	return c:GetSummonPlayer()==tp
end
function c511002661.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002661.cfilter,1,nil,1-tp)
end
function c511002661.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(Card.IsReleasable,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return ct>0 and g:GetCount()==ct end
	Duel.Release(g,REASON_COST)
end
function c511002661.spfilter(c,e,sp)
	return c:IsRace(RACE_INSECT) and c:IsCanBeSpecialSummoned(e,0,sp,false,false)
end
function c511002661.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 
		and Duel.IsExistingMatchingCard(c511002661.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511002661.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002661.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
