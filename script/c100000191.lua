--トリプル・エース
function c100000191.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c100000191.target)
	e1:SetOperation(c100000191.operation)
	c:RegisterEffect(e1)
end
function c100000191.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()==1
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,2,c,c:GetCode())
end
function c100000191.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c100000191.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>2
		and Duel.IsExistingTarget(c100000191.filter,tp,LOCATION_HAND,0,3,nil,e,tp) end	
end
function c100000191.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c100000191.filter,tp,LOCATION_HAND,0,3,3,nil,e,tp)
	if tc:GetCount()~=3 then return end
	Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
end
