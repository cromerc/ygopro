--Hyper Galaxy
function c511001628.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001628.cost)
	e1:SetTarget(c511001628.target)
	e1:SetOperation(c511001628.activate)
	c:RegisterEffect(e1)
end
function c511001628.cfilter(c)
	return c:IsFaceup() and c:IsAttackAbove(2000) and c:IsReleasable()
end
function c511001628.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001628.cfilter,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.IsExistingMatchingCard(c511001628.cfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g1=Duel.SelectMatchingCard(tp,c511001628.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g2=Duel.SelectMatchingCard(tp,c511001628.cfilter,tp,0,LOCATION_MZONE,1,1,nil)
	g1:Merge(g2)
	Duel.Release(g1,REASON_COST)
end
function c511001628.filter(c,e,tp)
	return c:IsCode(93717133) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511001628.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511001628.filter,tp,0x13,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c511001628.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001628.filter,tp,0x13,LOCATION_GRAVE,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
