--Two-for-One Repair Job
function c511002411.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)	
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002411.target)
	e1:SetOperation(c511002411.activate)
	c:RegisterEffect(e1)
end
function c511002411.filter(c,e,tp)
	return (c:IsSetCard(0x219) or c:IsCode(82556058)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
		and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511002411.rfilter(c)
	return (c:IsSetCard(0x219) or c:IsCode(82556058)) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c511002411.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511002411.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511002411.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002411.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
	Duel.BreakEffect()
	local rg=Duel.GetMatchingGroup(c511002411.rfilter,tp,LOCATION_GRAVE,0,nil)
	if rg:GetCount()>0 then
		Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
	end
end
