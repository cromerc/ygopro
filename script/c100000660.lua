 --鉛のコンパス
function c100000660.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100000660.condition)
	e1:SetTarget(c100000660.target)
	e1:SetOperation(c100000660.activate)
	c:RegisterEffect(e1)
end
function c100000660.spfilter(c,e,tp)
	return c:IsCode(100000654) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c100000660.cfilter(c)
	return c:IsFaceup() and c:IsCode(100000650)
end
function c100000660.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000660.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
	and Duel.IsExistingMatchingCard(c100000660.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp)
end
function c100000660.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK+LOCATION_HAND)
end
function c100000660.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000660.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
