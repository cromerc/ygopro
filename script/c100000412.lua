--白薔薇の回廊
function c100000412.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000412,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c100000412.target)
	e2:SetOperation(c100000412.operation)
	c:RegisterEffect(e2)
end
c100000412.collection={
	[49674183]=true;[96470883]=true;[31986288]=true;[41160533]=true;[51085303]=true;
	[41201555]=true;[75252099]=true;[58569561]=true;[96385345]=true;[17720747]=true;
	[98884569]=true;[23087070]=true;[1557341]=true;[12469386]=true;[2986553]=true;
	[51852507]=true;[44125452]=true;[61049315]=true;[79531196]=true;[89252157]=true;
	[32485271]=true;[33698022]=true;[73580471]=true;[4290468]=true;[25090294]=true;
	[45247637]=true;[71645243]=true;[73580471]=true;[4290468]=true;[25090294]=true;
}
function c100000412.filter(c,e,sp)
	return (c:IsSetCard(0x218) or c100000412.collection[c:GetCode()]) and c:IsCanBeSpecialSummoned(e,0,sp,false,false)
end
function c100000412.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c100000412.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c100000412.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000412.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
