--ヘルモスの爪
function c5686.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,5686+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c5686.target)
	e1:SetOperation(c5686.activate)
	c:RegisterEffect(e1)
	--add code
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_ADD_CODE)
	e2:SetValue(10000052)
	c:RegisterEffect(e2)
end
function c5686.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c5686.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND+LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c5686.spfilter(c,e,tp)
	local f=c.hermos_filter
	if not f or not c:IsCanBeSpecialSummoned(e,0,tp,true,false) then return false end
	local loc=LOCATION_HAND+LOCATION_MZONE
	if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then loc=LOCATION_MZONE end
	return Duel.IsExistingMatchingCard(c5686.tgfilter,tp,loc,0,1,nil,f)
end
function c5686.tgfilter(c,f)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave() and f(c)
end
function c5686.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c5686.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local sc=sg:GetFirst()
	if sc then
		local f=sc.hermos_filter
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local loc=LOCATION_HAND+LOCATION_MZONE
		if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then loc=LOCATION_MZONE end
		local tg=Duel.SelectMatchingCard(tp,c5686.tgfilter,tp,loc,0,1,1,nil,f)
		local tc=tg:GetFirst()
		if tc:IsLocation(LOCATION_MZONE) and tc:IsFacedown() then Duel.ConfirmCards(1-tp,tc) end
		Duel.SendtoGrave(tc,REASON_EFFECT)
		Duel.BreakEffect()
		Duel.SpecialSummon(sc,0,tp,tp,true,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
