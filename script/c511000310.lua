--Doctor D
function c511000310.initial_effect(c)
	--Special Summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_ACTIVATE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetCost(c511000310.spcost)
	e3:SetTarget(c511000310.sptg)
	e3:SetOperation(c511000310.spop)
	c:RegisterEffect(e3)
end
function c511000310.spfilter(c,e,tp)
	return c:IsSetCard(0xc008) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000310.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000310.costfilter2,tp,LOCATION_GRAVE,0,2,nil)
	and Duel.IsExistingMatchingCard(c511000310.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	local sg=Duel.GetMatchingGroup(c511000310.spfilter,tp,LOCATION_GRAVE,0,nil,e,tp)
	local g=nil
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	if sg:GetCount()==1 then
		g=Duel.SelectMatchingCard(tp,c511000310.costfilter1,tp,LOCATION_GRAVE,0,1,1,nil)
	else
		g=Duel.SelectMatchingCard(tp,c511000310.costfilter2,tp,LOCATION_GRAVE,0,1,1,nil)
	end
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511000310.costfilter1(c)
	return c:IsSetCard(0xc008) and c:IsAbleToRemoveAsCost() and c:IsLevelAbove(5)
end
function c511000310.costfilter2(c)
	return c:IsSetCard(0xc008) and c:IsAbleToRemoveAsCost()
end
function c511000310.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000310.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511000310.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511000310.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
