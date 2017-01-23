--黒魔族復活の棺
function c100000073.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c100000073.condition)
	e1:SetTarget(c100000073.target)
	e1:SetOperation(c100000073.activate)
	c:RegisterEffect(e1)
end
function c100000073.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and tc:IsFaceup() and tc:GetSummonPlayer()~=tp and tc:IsAbleToGrave()
end
function c100000073.filter(c,e,tp)
	return c:IsRace(RACE_SPELLCASTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000073.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.IsExistingMatchingCard(c100000073.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_GRAVE)
end
function c100000073.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local tg=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,LOCATION_MZONE,0,1,1,nil)
		tg:AddCard(tc)
		Duel.SendtoGrave(tg,REASON_EFFECT)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c100000073.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
