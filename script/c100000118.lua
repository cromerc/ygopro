--おジャマ・ゲットライド！
function c100000118.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100000118.cost)
	e1:SetTarget(c100000118.target)
	e1:SetOperation(c100000118.activate)
	c:RegisterEffect(e1)
end
function c100000118.costfilter(c,code)
	return c:IsAbleToGraveAsCost() and c:IsCode(code)
end
function c100000118.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000118.costfilter,tp,LOCATION_HAND,0,1,nil,12482652)
		and Duel.IsExistingMatchingCard(c100000118.costfilter,tp,LOCATION_HAND,0,1,nil,42941100)
		and Duel.IsExistingMatchingCard(c100000118.costfilter,tp,LOCATION_HAND,0,1,nil,79335209) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c100000118.costfilter,tp,LOCATION_HAND,0,1,1,nil,12482652)	
	local g2=Duel.SelectMatchingCard(tp,c100000118.costfilter,tp,LOCATION_HAND,0,1,1,nil,42941100)
	g1:Merge(g2)
	local g3=Duel.SelectMatchingCard(tp,c100000118.costfilter,tp,LOCATION_HAND,0,1,1,nil,79335209)
	g1:Merge(g3)
	Duel.SendtoGrave(g1,REASON_COST)
end
function c100000118.filter(c,e,tp)
	return c:GetLevel()<=4 and c:IsRace(RACE_MACHINE) and c:IsType(TYPE_UNION) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000118.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c100000118.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,tp,LOCATION_DECK)
end
function c100000118.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>3 then ft=3 end
	if ft<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000118.filter,tp,LOCATION_DECK,0,1,ft,nil,e,tp)
	local tc=g:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
end
