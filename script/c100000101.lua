--おジャマンダラ
function c100000101.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100000101.cost)
	e1:SetTarget(c100000101.target)
	e1:SetOperation(c100000101.activate)
	c:RegisterEffect(e1)
end
function c100000101.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c100000101.filter(c,code,e,tp)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000101.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>2 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsExistingMatchingCard(c100000101.filter,tp,LOCATION_GRAVE,0,1,nil,12482652,e,tp) 
		and Duel.IsExistingMatchingCard(c100000101.filter,tp,LOCATION_GRAVE,0,1,nil,42941100,e,tp) 
		and Duel.IsExistingMatchingCard(c100000101.filter,tp,LOCATION_GRAVE,0,1,nil,79335209,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,0,3,0,0)
end
function c100000101.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c100000101.filter,tp,LOCATION_GRAVE,0,nil,12482652,e,tp)
	local g2=Duel.GetMatchingGroup(c100000101.filter,tp,LOCATION_GRAVE,0,nil,42941100,e,tp)
	local g3=Duel.GetMatchingGroup(c100000101.filter,tp,LOCATION_GRAVE,0,nil,79335209,e,tp)
	if g1:GetCount()>0 and g2:GetCount()>0 and g3:GetCount()>0 and not Duel.IsPlayerAffectedByEffect(tp,59822133) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg2=g2:Select(tp,1,1,nil)
		sg1:Merge(sg2)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg3=g3:Select(tp,1,1,nil)
		sg1:Merge(sg3)
		Duel.SpecialSummon(sg1,0,tp,tp,false,false,POS_FACEUP)
	end
end
