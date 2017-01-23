--Crowning of the Emperor
function c511000007.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000007.cost)
	e1:SetTarget(c511000007.target)
	e1:SetOperation(c511000007.operation)
	c:RegisterEffect(e1)
end
function c511000007.afilter(c, code)
	return c:IsCode(511000005) and c:IsFaceup()
end
function c511000007.bfilter(c,e,tp)
	return c:IsCode(511000006) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c511000007.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c511000007.afilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c511000007.afilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c511000007.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511000007.bfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511000007.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000007.bfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)	
	end
end