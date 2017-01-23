--薔薇の聖騎士
function c100000410.initial_effect(c)
	--sp summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCost(c100000410.spcost)
	e1:SetTarget(c100000410.sptg)
	e1:SetOperation(c100000410.spop)
	c:RegisterEffect(e1)
end
c100000410.collection={
	[49674183]=true;[96470883]=true;[31986288]=true;[41160533]=true;[51085303]=true;
	[41201555]=true;[75252099]=true;[58569561]=true;[96385345]=true;[17720747]=true;
	[98884569]=true;[23087070]=true;[1557341]=true;[12469386]=true;[2986553]=true;
	[51852507]=true;[44125452]=true;[61049315]=true;[79531196]=true;[89252157]=true;
	[32485271]=true;[33698022]=true;[73580471]=true;[4290468]=true;[25090294]=true;
	[45247637]=true;[71645243]=true;[73580471]=true;[4290468]=true;[25090294]=true;
}
function c100000410.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c100000410.filter(c,e,tp)
	return (c:IsSetCard(0x218) or c100000410.collection[c:GetCode()]) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000410.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 
		and Duel.IsExistingMatchingCard(c100000410.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c100000410.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000410.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
