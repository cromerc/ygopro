--Double Ripple
function c511000056.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000056.target)
	e1:SetOperation(c511000056.activate)
	c:RegisterEffect(e1)
end
function c511000056.filter1(c,ntg)
	local lv=c:GetLevel()
	return c:IsFaceup() and lv>0 and c:IsType(TYPE_TUNER) and ntg:CheckWithSumEqual(Card.GetLevel,7-lv,1,99)
end
function c511000056.filter2(c)
	return c:IsFaceup() and c:GetLevel()>0 and not c:IsType(TYPE_TUNER) 
end
function c511000056.spfilter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000056.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local nt=Duel.GetMatchingGroup(c511000056.filter2,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c511000056.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,2403771)
		and	Duel.IsExistingMatchingCard(c511000056.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,25862681)
		and Duel.IsExistingMatchingCard(c511000056.filter1,tp,LOCATION_MZONE,0,1,nil,nt)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c511000056.activate(e,tp,eg,ep,ev,re,r,rp)
	local nt=Duel.GetMatchingGroup(c511000056.filter2,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511000056.filter1,tp,LOCATION_MZONE,0,1,1,nil,nt)
	local tc=g:GetFirst()
	if tc then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=nt:SelectWithSumEqual(tp,Card.GetLevel,7-tc:GetLevel(),1,99)
		g:Merge(sg)
		Duel.SendtoGrave(g,REASON_EFFECT)
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sp1=Duel.SelectMatchingCard(tp,c511000056.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,2403771):GetFirst()
		Duel.SpecialSummonStep(sp1,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sp2=Duel.SelectMatchingCard(tp,c511000056.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,25862681):GetFirst()
		Duel.SpecialSummonStep(sp2,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		Duel.SpecialSummonComplete()
	end
end
