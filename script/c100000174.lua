--猫集会
function c100000174.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000174,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c100000174.condition)
	e2:SetTarget(c100000174.target)
	e2:SetOperation(c100000174.operation)
	c:RegisterEffect(e2)
end
c100000174.collection={
	[11439455]=true;[14878871]=true;[52346240]=true;[32933942]=true;[511001115]=true;
	[5506791]=true;[8634636]=true;[25531465]=true;[24140059]=true;[77790021]=true;
	[96501677]=true;[56399890]=true;[2729285]=true;[95841282]=true;[43352213]=true;
	[1761063]=true;[11021521]=true;[51777272]=true;[84224627]=true;
}
function c100000174.cfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0x305) or c100000174.collection[c:GetCode()])
end
function c100000174.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c100000174.cfilter,1,nil,tp)
end
function c100000174.filter(c,e,tp)
	return (c:IsSetCard(0x305) or c100000174.collection[c:GetCode()]) and c:IsLevelBelow(3) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000174.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingTarget(c100000174.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c100000174.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000174.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
