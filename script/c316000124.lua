--Dimension Dice
function c316000124.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetCondition(c316000124.con)
	e1:SetCost(c316000124.cost)
	e1:SetTarget(c316000124.target)
	e1:SetOperation(c316000124.activate)
	c:RegisterEffect(e1)
end
function c316000124.filter(c)
	return c:IsFaceup() and c:IsCode(511001152)
end
function c316000124.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c316000124.filter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.GetEnvironment()==511001152
end
function c316000124.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,2,nil) end
	local rg=Duel.SelectReleaseGroup(tp,nil,2,2,nil)
	Duel.Release(rg,REASON_COST)
end
function c316000124.filter2(c,e,tp)
	return c:IsCode(140000074) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c316000124.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c316000124.filter2,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK+LOCATION_HAND)
end
function c316000124.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c316000124.filter2,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
