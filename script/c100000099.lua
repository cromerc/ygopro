--バッド・エンド－悲しみの連鎖
function c100000099.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c100000099.condition)
	e1:SetTarget(c100000099.target)
	e1:SetOperation(c100000099.activate)
	c:RegisterEffect(e1)
end
function c100000099.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_SZONE,0,1,nil,100000096)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_SZONE,0,1,nil,100000097)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_SZONE,0,1,nil,100000098)
end
function c100000099.spfilter(c,e,tp)
	return c:IsCode(80513550) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c100000099.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c100000099.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp)end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c100000099.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c100000099.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetFirstTarget()
	if tg:IsRelateToEffect(e) then
		Duel.SpecialSummon(tg,0,tp,tp,true,false,POS_FACEUP)		
		tg:CompleteProcedure()
	end
end