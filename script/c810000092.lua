--Luminous Clouds
--scripted by: UnknownGuest
function c810000092.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c810000092.cost)
	e1:SetTarget(c810000092.target)
	e1:SetOperation(c810000092.activate)
	c:RegisterEffect(e1)
end
function c810000092.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsCode,1,nil,24530661)
		and Duel.CheckReleaseGroup(tp,Card.IsCode,1,nil,810000091) end
	local g1=Duel.SelectReleaseGroup(tp,Card.IsCode,1,1,nil,24530661)
	local g2=Duel.SelectReleaseGroup(tp,Card.IsCode,1,1,nil,810000091)
	g1:Merge(g2)
	Duel.Release(g1,REASON_COST)
end
function c810000092.filter(c,e,tp)
	return c:IsCode(810000093) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c810000092.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c810000092.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c810000092.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c810000092.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	end
end
