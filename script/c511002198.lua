--Jester Puppet Acrobat
function c511002198.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(423585,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511002198.spcost)
	e1:SetTarget(c511002198.sptg)
	e1:SetOperation(c511002198.spop)
	c:RegisterEffect(e1)
end
function c511002198.costfilter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost() 
		and Duel.IsExistingMatchingCard(c511002198.filter,tp,LOCATION_HAND,0,1,c,e,tp)
end
function c511002198.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002198.costfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511002198.costfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511002198.filter(c,e,tp)
	return c:GetLevel()==4 and (c:IsCode(511002198) or c:IsCode(511002196) or c:IsCode(511000810)) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002198.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511002198.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002198.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
