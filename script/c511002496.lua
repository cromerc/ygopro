--Pixie Gong
function c511002496.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511002496.condition)
	e1:SetTarget(c511002496.target)
	e1:SetOperation(c511002496.activate)
	c:RegisterEffect(e1)
end
function c511002496.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.GetAttackTarget()==nil
end
c511002496.collection={
	[35429292]=true;[73837870]=true;[4179255]=true;[68401546]=true;[73507661]=true;
	[81563416]=true;[91559748]=true;[8687195]=true;[85239662]=true;[44125452]=true;
	[28290705]=true;[45425051]=true;[19684740]=true; --Pixie
	
	[66836598]=true;[37160778]=true;[48742406]=true;[22419772]=true;[45939611]=true;
	[44125452]=true;[79575620]=true;[25862681]=true;[23454876]=true;[51960178]=true;
	[20315854]=true;[1761063]=true;[6979239]=true; --Fairy
	
	[44663232]=true;[58753372]=true;[90925163]=true;[55623480]=true;[42921475]=true; --Fairy + Pixie
}
function c511002496.spfilter(c,e,tp)
	return (c:IsSetCard(0x412) or c:IsSetCard(0x413) or c511002496.collection[c:GetCode()]) and c:IsLevelBelow(3) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002496.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511002496.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511002496.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002496.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
