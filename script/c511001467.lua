--Marionette Burial
function c511001467.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001467.condition)
	e1:SetTarget(c511001467.target)
	e1:SetOperation(c511001467.activate)
	c:RegisterEffect(e1)
end
function c511001467.cfilter(c)
	return c:IsFaceup() and c:IsCode(511001466)
end
function c511001467.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001467.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511001467.tgfilter(c,code)
	return c:IsFaceup() and c:IsCode(code) and c:IsAbleToGrave()
end
function c511001467.spfilter(c,e,tp)
	return c:IsCode(511001468) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511001467.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511001467.tgfilter,tp,LOCATION_MZONE,0,1,nil,511001462) 
		and Duel.IsExistingMatchingCard(c511001467.tgfilter,tp,LOCATION_MZONE,0,1,nil,511001464) 
		and Duel.IsExistingMatchingCard(c511001467.tgfilter,tp,LOCATION_MZONE,0,1,nil,511001461) 
		and Duel.IsExistingMatchingCard(c511001467.tgfilter,tp,LOCATION_MZONE,0,1,nil,511001463) 
		and Duel.IsExistingMatchingCard(c511001467.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,4,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511001467.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c511001467.tgfilter,tp,LOCATION_MZONE,0,nil,511001462)
	local g2=Duel.GetMatchingGroup(c511001467.tgfilter,tp,LOCATION_MZONE,0,nil,511001464)
	local g3=Duel.GetMatchingGroup(c511001467.tgfilter,tp,LOCATION_MZONE,0,nil,511001461)
	local g4=Duel.GetMatchingGroup(c511001467.tgfilter,tp,LOCATION_MZONE,0,nil,511001463)
	local sp=Duel.GetMatchingGroup(c511001467.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=-1 then return end
	if g1:GetCount()>0 and g2:GetCount()>0 and g3:GetCount()>0 and g4:GetCount()>0 
		and sp:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg2=g2:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg3=g3:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg4=g4:Select(tp,1,1,nil)
		sg1:Merge(sg2)
		sg1:Merge(sg3)
		sg1:Merge(sg4)
		if Duel.SendtoGrave(sg1,REASON_EFFECT) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local spg=sp:Select(tp,1,1,nil)
			if spg:GetCount()>0 and Duel.SpecialSummon(spg,0,tp,tp,true,true,POS_FACEUP) then
				spg:GetFirst():CompleteProcedure()
			end
		end
	end
end
