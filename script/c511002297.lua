--Atmospheric Regeneration
function c511002297.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c511002297.condition)
	e1:SetTarget(c511002297.target)
	e1:SetOperation(c511002297.activate)
	c:RegisterEffect(e1)
end
function c511002297.cfilter(c)
	return c:IsCode(511002289) or c:IsCode(511002290) or c:IsCode(14466224) or c:IsCode(72144675) 
		or c:IsCode(66094973) or c:IsCode(511002291) or c:IsCode(511002292)
end
function c511002297.filter(c,e,tp)
	return (c:IsCode(511002289) or c:IsCode(511002290) or c:IsCode(14466224) or c:IsCode(72144675) 
		or c:IsCode(66094973) or c:IsCode(511002291) or c:IsCode(511002292)) and c:IsLevelBelow(4) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511002297.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002297.cfilter,1,nil)
end
function c511002297.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511002297.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511002297.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002297.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
