--究極進化薬
function c100000318.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100000318.cost)
	e1:SetTarget(c100000318.target)
	e1:SetOperation(c100000318.activate)
	c:RegisterEffect(e1)
end
function c100000318.cfilter1(c,e,tp)
	return c:IsRace(RACE_MACHINE) and c:IsAbleToRemoveAsCost() 
		and Duel.IsExistingMatchingCard(c100000318.cfilter2,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,c,e,tp,c)
end
function c100000318.cfilter2(c,e,tp,rc)
	return c:IsRace(RACE_DINOSAUR) and c:IsAbleToRemoveAsCost() 
		and Duel.IsExistingMatchingCard(c100000318.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,c,e,tp,rc)
end
function c100000318.filter(c,e,tp,rc)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_DINOSAUR) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
		and c~=rc
end
function c100000318.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000318.cfilter1,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c100000318.cfilter1,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c100000318.cfilter2,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,g1:GetFirst(),e,tp,g1:GetFirst())
	g1:Merge(g2)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c100000318.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c100000318.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000318.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp,nil)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
