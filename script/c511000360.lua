--Spark of the Light Dragon
function c511000360.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000360.cost)
	e1:SetTarget(c511000360.target)
	e1:SetOperation(c511000360.operation)
	c:RegisterEffect(e1)
end
function c511000360.costfilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsAbleToGraveAsCost()
end
function c511000360.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000360.costfilter,tp,LOCATION_HAND,0,2,nil) end
	Duel.DiscardHand(tp,c511000360.costfilter,2,2,REASON_COST)
end
function c511000360.spfilter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_DRAGON) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000360.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(c511000360.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511000360.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000360.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()~=0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
