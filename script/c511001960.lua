--Illegal Modding
function c511001960.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001960.cost)
	e1:SetTarget(c511001960.target)
	e1:SetOperation(c511001960.activate)
	c:RegisterEffect(e1)
end
function c511001960.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsCode,1,nil,511000813)
		and Duel.CheckReleaseGroup(tp,Card.IsCode,1,nil,511000827)
		and Duel.CheckReleaseGroup(tp,Card.IsCode,1,nil,511001958)	end
	local rg1=Duel.SelectReleaseGroup(tp,Card.IsCode,1,1,nil,511000813)
	local rg2=Duel.SelectReleaseGroup(tp,Card.IsCode,1,1,nil,511000827)
	local rg3=Duel.SelectReleaseGroup(tp,Card.IsCode,1,1,nil,511001958)
	rg1:Merge(rg2)
	rg1:Merge(rg3)
	Duel.Release(rg1,REASON_COST)
end
function c511001960.spfilter(c,e,tp)
	return c:IsCode(511001959) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001960.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001960.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511001960.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c511001960.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if sg:GetCount()>0 then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
