--Battle Constant
function c511001234.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001234.cost)
	e1:SetTarget(c511001234.target)
	e1:SetOperation(c511001234.activate)
	c:RegisterEffect(e1)
end
function c511001234.filter1(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c511001234.filter2(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL) and c:IsType(TYPE_CONTINUOUS) and c:IsAbleToRemoveAsCost()
end
function c511001234.filter3(c)
	return c:IsFaceup() and c:IsType(TYPE_TRAP) and c:IsType(TYPE_CONTINUOUS) and c:IsAbleToRemoveAsCost()
end
function c511001234.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001234.filter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c511001234.filter2,tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsExistingMatchingCard(c511001234.filter3,tp,LOCATION_ONFIELD,0,1,nil)  end
	local g1=Duel.SelectMatchingCard(tp,c511001234.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	local g2=Duel.SelectMatchingCard(tp,c511001234.filter2,tp,LOCATION_ONFIELD,0,1,1,nil)
	g1:Merge(g2)
	local g3=Duel.SelectMatchingCard(tp,c511001234.filter3,tp,LOCATION_ONFIELD,0,1,1,nil)
	g1:Merge(g3)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c511001234.filter(c,e,tp)
	return c:IsCode(511001235) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001234.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511001234.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511001234.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001234.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end

