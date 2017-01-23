--トリプル・エース
function c100000191.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000191.target)
	e1:SetOperation(c100000191.operation)
	c:RegisterEffect(e1)
end
function c100000191.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()==1
		and Duel.IsExistingMatchingCard(c100000191.cfilter,tp,LOCATION_HAND,0,2,c,c:GetCode(),e,tp)
end
function c100000191.cfilter(c,code,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()==1 and c:IsCode(code)
end
function c100000191.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>2 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsExistingMatchingCard(c100000191.filter,tp,LOCATION_HAND,0,3,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,tp,LOCATION_HAND)
end
function c100000191.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=2 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c100000191.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g1:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(tp,c100000191.cfilter,tp,LOCATION_HAND,0,2,2,g1:GetFirst(),g1:GetFirst():GetCode(),e,tp)
		g1:Merge(g2)
		Duel.SpecialSummon(g1,0,tp,tp,false,false,POS_FACEUP)
	end
end
