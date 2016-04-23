--クリティウスの牙
function c5675.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,5675+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c5675.target)
	e1:SetOperation(c5675.activate)
	c:RegisterEffect(e1)
	--add code
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_ADD_CODE)
	e2:SetValue(10000051)
	c:RegisterEffect(e2)
end
function c5675.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c5675.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND+LOCATION_ONFIELD)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c5675.spfilter(c,e,tp)
	local f=c.critias_filter
	if not f or not c:IsCanBeSpecialSummoned(e,0,tp,true,false) then return false end
	return Duel.IsExistingMatchingCard(c5675.tgfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil,f)
end
function c5675.tgfilter(c,f)
	return c:IsType(TYPE_TRAP) and c:IsAbleToGrave() and f(c)
end
function c5675.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c5675.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local sc=sg:GetFirst()
	if sc then
		local f=sc.critias_filter
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local tg=Duel.SelectMatchingCard(tp,c5675.tgfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil,f)
		local tc=tg:GetFirst()
		if tc:IsLocation(LOCATION_ONFIELD) and tc:IsFacedown() then Duel.ConfirmCards(1-tp,tc) end
		Duel.SendtoGrave(tc,REASON_EFFECT)
		Duel.BreakEffect()
		Duel.SpecialSummon(sc,0,tp,tp,true,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
