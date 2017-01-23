--フラットＬＶ４
function c511000631.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000631,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetTarget(c511000631.target)
	e1:SetOperation(c511000631.activate)
	c:RegisterEffect(e1)
end
function c511000631.filter(c,e,tp)
	return c:GetLevel()==4 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000631.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511000631.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000631.filter,tp,LOCATION_DECK,0,1,nil,e,tp)
		and Duel.SelectYesNo(tp,aux.Stringid(511000631,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g1=Duel.SelectMatchingCard(tp,c511000631.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		Duel.SpecialSummonStep(g1:GetFirst(),0,tp,tp,false,false,POS_FACEUP)
	end
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000631.filter,1-tp,LOCATION_DECK,0,1,nil,e,1-tp)
		and Duel.SelectYesNo(1-tp,aux.Stringid(511000631,1)) then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(1-tp,c511000631.filter,1-tp,LOCATION_DECK,0,1,1,nil,e,1-tp)
		Duel.SpecialSummonStep(g2:GetFirst(),0,1-tp,1-tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end