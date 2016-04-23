--黒魔族復活の棺
function c100000073.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c100000073.condition)
	e1:SetTarget(c100000073.target)
	e1:SetOperation(c100000073.activate)
	c:RegisterEffect(e1)
end
function c100000073.ter(c)
	return c:IsType(TYPE_MONSTER)
end
function c100000073.condition(c)
	return Duel.IsExistingMatchingCard(c100000073.ter,tp,LOCATION_MZONE,0,1,nil) 
end 
function c100000073.filt(c,tp)
	return c:IsFaceup()	and c:GetSummonPlayer()~=tp and c:IsAbleToGrave()	
end
function c100000073.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return eg:IsExists(c100000073.filt,1,nil,tp) end
	local g=eg:Filter(c100000073.filter,nil,tp)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
end
function c100000073.filter(c,e,tp)
	return c:IsRace(RACE_SPELLCASTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000073.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local td=Duel.SelectMatchingCard(tp,c100000073.ter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	if td:GetCount()>0 and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.SendtoGrave(td,REASON_EFFECT)
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end	
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c100000073.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000073.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000073.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end
