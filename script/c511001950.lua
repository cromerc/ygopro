--All-Out Rebellion
function c511001950.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001950.condition)
	e1:SetTarget(c511001950.target)
	e1:SetOperation(c511001950.activate)
	c:RegisterEffect(e1)
end
function c511001950.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
end
function c511001950.filter(c,e,tp)
	return c:IsSetCard(0x214) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
		and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511001950.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>=ct
		and Duel.IsExistingMatchingCard(c511001950.filter,tp,LOCATION_GRAVE,0,ct,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511001950.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<ct then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001950.filter,tp,LOCATION_GRAVE,0,ct,ct,nil,e,tp)
	if g:GetCount()==ct then
		Duel.HintSelection(g)
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
