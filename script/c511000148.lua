--Five Star Twilight
function c511000148.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000148.cost)
	e1:SetTarget(c511000148.target)
	e1:SetOperation(c511000148.activate)
	c:RegisterEffect(e1)
end
function c511000148.cfilter(c)
	return c:GetLevel()==5
end
function c511000148.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c511000148.cfilter,1,nil) end
	local rg=Duel.SelectReleaseGroup(tp,c511000148.cfilter,1,1,nil)
	Duel.Release(rg,REASON_COST)
end
function c511000148.filter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000148.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>3 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsExistingMatchingCard(c511000148.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp,40640057) 
		and Duel.IsExistingMatchingCard(c511000148.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp,511000153) 
		and Duel.IsExistingMatchingCard(c511000148.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp,511000151) 
		and Duel.IsExistingMatchingCard(c511000148.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp,511000152) 
		and Duel.IsExistingMatchingCard(c511000148.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp,511000154) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,5,tp,LOCATION_DECK+LOCATION_HAND)
end
function c511000148.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=4 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g1=Duel.GetMatchingGroup(c511000148.filter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e,tp,40640057)
	local g2=Duel.GetMatchingGroup(c511000148.filter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e,tp,511000153)
	local g3=Duel.GetMatchingGroup(c511000148.filter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e,tp,511000151)
	local g4=Duel.GetMatchingGroup(c511000148.filter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e,tp,511000152)
	local g5=Duel.GetMatchingGroup(c511000148.filter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e,tp,511000154)
	if g1:GetCount()>0 and g2:GetCount()>0 and g3:GetCount()>0 and g4:GetCount()>0 and g5:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg2=g2:Select(tp,1,1,nil)
		sg1:Merge(sg2)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg3=g3:Select(tp,1,1,nil)
		sg1:Merge(sg3)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg4=g4:Select(tp,1,1,nil)
		sg1:Merge(sg4)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg5=g5:Select(tp,1,1,nil)
		sg1:Merge(sg5)
		local tc=sg1:GetFirst()
		while tc do
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UNRELEASABLE_SUM)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(1)
			tc:RegisterEffect(e1,true)
			tc=sg1:GetNext()
		end
		Duel.SpecialSummonComplete()
	end
end
