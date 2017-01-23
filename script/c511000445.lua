--Miracle Moment
function c511000445.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511000445.condition)
	e1:SetTarget(c511000445.target)
	e1:SetOperation(c511000445.activate)
	c:RegisterEffect(e1)
end
function c511000445.cfilter(c)
	return c:GetPreviousControler()==tp and c:IsReason(REASON_BATTLE) and c:IsCode(42035044) and c:GetEquipGroup():IsExists(Card.IsCode,1,nil,511000443)
end
function c511000445.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000445.cfilter,nil,tp)
	return g
end
function c511000445.spfilter(c,e,tp)
	return c:IsCode(511000444) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000445.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c511000445.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511000445.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000445.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
