--Sealed Gate
function c511000597.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetDescription(aux.Stringid(511000597,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c511000597.spcon)
	e1:SetCost(c511000597.spcost)
	e1:SetTarget(c511000597.sptg)
	e1:SetOperation(c511000597.spop)
	c:RegisterEffect(e1)
end
function c511000597.cfilter(c,code)
	return c:IsCode(code) and c:IsAbleToRemoveAsCost()
end
function c511000597.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000597.cfilter,tp,LOCATION_GRAVE,0,1,nil,511000596)
	and Duel.IsExistingMatchingCard(c511000597.cfilter,tp,LOCATION_GRAVE,0,1,nil,511000594)
	and Duel.IsExistingMatchingCard(c511000597.cfilter,tp,LOCATION_GRAVE,0,1,nil,511000593) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c511000597.cfilter,tp,LOCATION_GRAVE,0,1,1,nil,511000596)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c511000597.cfilter,tp,LOCATION_GRAVE,0,1,1,nil,511000594)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g3=Duel.SelectMatchingCard(tp,c511000597.cfilter,tp,LOCATION_GRAVE,0,1,1,nil,511000593)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c511000597.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY)
end
function c511000597.filter(c,e,tp)
	return c:IsCode(511000595) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000597.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000597.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511000597.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000597.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		Duel.ShuffleDeck(tp)
	end
end
