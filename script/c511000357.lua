--Guidance of Light and Dark
function c511000357.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCost(c511000357.spcost)
	e1:SetCondition(c511000357.spcon)
	e1:SetTarget(c511000357.sptg)
	e1:SetOperation(c511000357.spop)
	c:RegisterEffect(e1)
end
function c511000357.costfilter(c)
	return c:IsCode(47297616) and c:IsAbleToRemoveAsCost()
end
function c511000357.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000357.costfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511000357.costfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511000357.spfilter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_DARK+ATTRIBUTE_LIGHT) and c:IsRace(RACE_DRAGON) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000357.cfilter(c,tp)
	return c:IsRace(RACE_DRAGON) and c:GetPreviousControler()==tp and c:GetPreviousLocation()==LOCATION_MZONE
end
function c511000357.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000357.cfilter,1,nil,tp)
end
function c511000357.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000357.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511000357.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000357.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
