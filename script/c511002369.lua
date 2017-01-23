--Instant Mask Change
function c511002369.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002369.condition)
	e1:SetTarget(c511002369.target)
	e1:SetOperation(c511002369.activate)
	c:RegisterEffect(e1)
end
function c511002369.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
end
function c511002369.tfilter(c,att,e,tp)
	return c:IsSetCard(0xa008) and c:GetLevel()==8 and c:IsAttribute(att) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511002369.filter(c,e,tp)
	return c:IsSetCard(0xa008)
		and Duel.IsExistingMatchingCard(c511002369.tfilter,tp,LOCATION_EXTRA,0,1,nil,c:GetAttribute(),e,tp)
end
function c511002369.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511002369.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511002369.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511002369.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()<=0 or Duel.SendtoGrave(g,REASON_EFFECT)==0 then return end
	local att=g:GetFirst():GetAttribute()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c511002369.tfilter,tp,LOCATION_EXTRA,0,1,1,nil,att,e,tp)
	if sg:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SpecialSummon(sg,0,tp,tp,true,false,POS_FACEUP)
		sg:GetFirst():CompleteProcedure()
	end
end
