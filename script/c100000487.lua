--レッドアイズ・トランスマイグレーション
function c100000487.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000487.target)
	e1:SetOperation(c100000487.activate)
	c:RegisterEffect(e1)
end
function c100000487.mfilter1(c,e)
	return c:IsCode(74677422) and not c:IsImmuneToEffect(e) and c:IsReleasable()
end
function c100000487.mfilter2(c,e)
	return c:IsRace(RACE_WARRIOR) and not c:IsImmuneToEffect(e) and c:IsReleasable()
end
function c100000487.filter(c,e,tp)
	return bit.band(c:GetType(),0x81)==0x81 and c:IsCode(100000486) 
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false)
end
function c100000487.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		return Duel.IsExistingMatchingCard(c100000487.filter,tp,LOCATION_HAND,0,1,nil,e,tp)
		 and Duel.IsExistingMatchingCard(c100000487.mfilter1,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil,e)
		 and Duel.IsExistingMatchingCard(c100000487.mfilter2,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil,e)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c100000487.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,c100000487.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if tg:GetCount()>0 then
		local tc=tg:GetFirst()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local mat=Duel.SelectMatchingCard(tp,c100000487.mfilter1,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,e)
		local mat2=Duel.SelectMatchingCard(tp,c100000487.mfilter2,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,e)
		mat:Merge(mat2)
		tc:SetMaterial(mat)
		Duel.ReleaseRitualMaterial(mat)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
