--Dragon Switch
function c511000343.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000343.cost)
	e1:SetTarget(c511000343.target)
	e1:SetOperation(c511000343.activate)
	c:RegisterEffect(e1)
end
function c511000343.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsRace,2,nil,RACE_DRAGON) end
	local rg=Duel.SelectReleaseGroup(tp,Card.IsRace,2,2,nil,RACE_DRAGON)
	Duel.Release(rg,REASON_COST)
end
function c511000343.spfilter(c,e,tp)
	return c:IsRace(RACE_DRAGON) and c:IsLevelAbove(7) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000343.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511000343.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511000343.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000343.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
