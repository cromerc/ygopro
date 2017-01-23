--Revival Knight
function c511002550.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_END_PHASE)
	e1:SetCondition(c511002550.condition)
	e1:SetTarget(c511002550.target)
	e1:SetOperation(c511002550.activate)
	c:RegisterEffect(e1)
end
function c511002550.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_END
end
function c511002550.filter(c,tid,e,tp)
	return c:IsReason(REASON_DESTROY) and (c:IsCode(511000008) or c:IsCode(511000957)) and c:GetTurnID()==tid
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetPreviousControler()==tp
end
function c511002550.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c511002550.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_GRAVE+LOCATION_REMOVED,nil,Duel.GetTurnCount(),e,tp)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and g:GetCount()==1 end
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511002550.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002550.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_GRAVE+LOCATION_REMOVED,nil,Duel.GetTurnCount(),e,tp)
	local tc=g:GetFirst()
	if g:GetCount()~=1 or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
