--Legend of Heart
function c170000201.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCost(c170000201.cost)
    e1:SetTarget(c170000201.target)
    e1:SetOperation(c170000201.operation)
	c:RegisterEffect(e1)
end
function c170000201.costfilter(c,code)
	return c:IsCode(code) and c:IsAbleToRemoveAsCost()
end
function c170000201.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.CheckLPCost(tp,1000) and Duel.CheckReleaseGroup(tp,Card.IsRace,1,nil,RACE_WARRIOR) 
    	and Duel.IsExistingMatchingCard(c170000201.costfilter,tp,0x1f,0,1,nil,1784686)
 		and Duel.IsExistingMatchingCard(c170000201.costfilter,tp,0x1f,0,1,nil,46232525)
		and Duel.IsExistingMatchingCard(c170000201.costfilter,tp,0x1f,0,1,nil,11082056) end
    Duel.PayLPCost(tp,1000)
	local rg=Duel.SelectReleaseGroup(tp,Card.IsRace,1,1,nil,RACE_WARRIOR)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOREMOVE)
	local g1=Duel.SelectMatchingCard(tp,c170000201.costfilter,tp,LOCATION_GRAVE+LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD,0,1,1,nil,1784686)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c170000201.costfilter,tp,LOCATION_GRAVE+LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD,0,1,1,nil,46232525)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g3=Duel.SelectMatchingCard(tp,c170000201.costfilter,tp,LOCATION_GRAVE+LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD,0,1,1,nil,11082056)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
	Duel.Release(rg,REASON_COST)
end
function c170000201.spfilter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c170000201.filter(c)
	return c:IsCode(48179391) or c:IsCode(110000100) or c:IsCode(110000101)
end
function c170000201.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 
		and Duel.IsExistingMatchingCard(c170000201.spfilter,tp,0x33,0,1,nil,e,tp,80019195)
		and Duel.IsExistingMatchingCard(c170000201.spfilter,tp,0x33,0,1,nil,e,tp,85800949)
		and Duel.IsExistingMatchingCard(c170000201.spfilter,tp,0x33,0,1,nil,e,tp,84565800) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,3,0,0)
end
function c170000201.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=2 then return end
	local g1=Duel.GetMatchingGroup(c170000201.spfilter,tp,0x33,0,nil,e,tp,80019195)
	local g2=Duel.GetMatchingGroup(c170000201.spfilter,tp,0x33,0,nil,e,tp,85800949)
	local g3=Duel.GetMatchingGroup(c170000201.spfilter,tp,0x33,0,nil,e,tp,84565800)
	if g1:GetCount()>0 and g2:GetCount()>0 and g3:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg2=g2:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg3=g3:Select(tp,1,1,nil)
		sg1:Merge(sg2)
		sg1:Merge(sg3)
		Duel.SpecialSummon(sg1,0,tp,tp,true,true,POS_FACEUP)
	end
	Duel.BreakEffect()
	local g=Duel.GetMatchingGroup(c170000201.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
	Duel.BreakEffect()
	Duel.Destroy(g,REASON_EFFECT)
	Duel.SendtoGrave(g,REASON_EFFECT)
end
