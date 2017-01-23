--魂の綱
function c511001593.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c511001593.condition)
	e1:SetCost(c511001593.cost)
	e1:SetTarget(c511001593.target)
	e1:SetOperation(c511001593.activate)
	c:RegisterEffect(e1)
end
function c511001593.cfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE)
end
function c511001593.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001593.cfilter,1,nil,tp)
end
function c511001593.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c511001593.spfilter(c,e,tp)
	return c:GetLevel()<=4 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001593.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511001593.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511001593.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001593.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
