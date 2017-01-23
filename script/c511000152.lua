--Kuribeh
function c511000152.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86585274,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511000152.spcost)
	e1:SetTarget(c511000152.sptg)
	e1:SetOperation(c511000152.spop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UNRELEASABLE_SUM)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c511000152.cfilter(c,code)
	return c:IsCode(code) and c:IsAbleToRemoveAsCost()
end
function c511000152.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c511000152.cfilter,tp,LOCATION_ONFIELD,0,1,nil,511000153) 
		and Duel.IsExistingMatchingCard(c511000152.cfilter,tp,LOCATION_ONFIELD,0,1,nil,511000151) 
		and Duel.IsExistingMatchingCard(c511000152.cfilter,tp,LOCATION_ONFIELD,0,1,nil,40640057) 
		and Duel.IsExistingMatchingCard(c511000152.cfilter,tp,LOCATION_ONFIELD,0,1,nil,511000154) 
		and c:IsAbleToRemoveAsCost() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c511000152.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil,511000153)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c511000152.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil,511000151)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g3=Duel.SelectMatchingCard(tp,c511000152.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil,40640057)
	g1:Merge(g3)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g4=Duel.SelectMatchingCard(tp,c511000152.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil,511000154)
	g1:Merge(g4)
	g1:AddCard(c)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c511000152.filter(c,e,tp)
	return c:IsCode(16404809) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511000152.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 
		and Duel.IsExistingMatchingCard(c511000152.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511000152.spop(e,tp,eg,ep,ev,re,r,rp,c)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c511000152.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
