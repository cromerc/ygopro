--Fang of Critias
function c170000151.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOGRAVE+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c170000151.target)
	e1:SetOperation(c170000151.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EFFECT_ADD_TYPE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c170000151.monval)
	c:RegisterEffect(e2)
end
function c170000151.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c170000151.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c170000151.spfilter(c,e,tp)
	local code=c.material_trap
	if not code or not c:IsCanBeSpecialSummoned(e,0,tp,true,false) then return false end
	return Duel.IsExistingMatchingCard(c170000151.tgfilter,tp,LOCATION_ONFIELD,0,1,nil,code)
end
function c170000151.tgfilter(c,code)
	return c:IsType(TYPE_TRAP) and c:IsAbleToGrave() and code==c:GetCode()
end
function c170000151.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c170000151.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local sc=sg:GetFirst()
	if sc then
		local code=sc.material_trap
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local tg=Duel.SelectMatchingCard(tp,c170000151.tgfilter,tp,LOCATION_ONFIELD,0,1,1,nil,code)
		tg:AddCard(e:GetHandler())
		Duel.SendtoGrave(tg,REASON_EFFECT)
		Duel.BreakEffect()
		Duel.SpecialSummon(sc,0,tp,tp,true,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
function c170000151.monval(e,c)
	if (c:IsOnField() and c:IsFacedown()) or c:IsLocation(LOCATION_GRAVE) then
		return TYPE_EFFECT+TYPE_MONSTER
	else
		return 0
	end
end
