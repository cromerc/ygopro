--浅すぎた墓穴
function c511002019.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002019.target)
	e1:SetOperation(c511002019.activate)
	c:RegisterEffect(e1)
end
function c511002019.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()==4
end
function c511002019.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002019.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.GetLocationCount(1-tp,LOCATION_MZONE,1-tp)>0 
		and Duel.IsExistingMatchingCard(c511002019.filter,tp,0,LOCATION_GRAVE,1,nil,e,1-tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511002019.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c511002019.filter,tp,LOCATION_GRAVE,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(c511002019.filter,1-tp,LOCATION_GRAVE,0,nil,e,1-tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 
		and g1:GetCount()>0 and g2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg1=g1:Select(tp,1,1,nil)
		local tc1=sg1:GetFirst()
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)
		local sg2=g2:Select(1-tp,1,1,nil)
		local tc2=sg2:GetFirst()
		sg1:Merge(sg2)
		Duel.HintSelection(sg1)
		Duel.SpecialSummonStep(tc1,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		Duel.SpecialSummonStep(tc2,0,1-tp,1-tp,false,false,POS_FACEUP_DEFENSE)
		Duel.SpecialSummonComplete()
	end
end
