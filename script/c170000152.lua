--Eye of Timaeus
function c170000152.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c170000152.target)
	e1:SetOperation(c170000152.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EFFECT_ADD_TYPE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c170000152.monval)
	c:RegisterEffect(e2)
end
function c170000152.filter1(c,e,tp)
	return Duel.IsExistingMatchingCard(c170000152.filter2,tp,LOCATION_EXTRA,0,1,nil,c:GetCode(),e,tp)
end
function c170000152.filter2(c,code,e,tp)
	if not c.material_count or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) then return false end
	for i=1,c.material_count do
		if code==c.material[i] then
			for i=1,c.material_count do
				if 1784686==c.material[i] then return true end
			end
		end
	end
	return false
end
function c170000152.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>=0
			and Duel.IsExistingMatchingCard(c170000152.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c170000152.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=-1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tg=Duel.SelectMatchingCard(tp,c170000152.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	local co=tg:GetFirst()
	tg:AddCard(e:GetHandler())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c170000152.filter2,tp,LOCATION_EXTRA,0,1,1,nil,co:GetCode(),e,tp)
	Duel.SendtoGrave(tg,REASON_EFFECT)
	Duel.BreakEffect()
	local sc=sg:GetFirst()
	if sg then
		sc:SetMaterial(tg)
		Duel.SendtoGrave(tg,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
		Duel.BreakEffect()
		Duel.SpecialSummon(sc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
function c170000152.monval(e,c)
	if (c:IsOnField() and c:IsFacedown()) or c:IsLocation(LOCATION_GRAVE) then
		return TYPE_EFFECT+TYPE_MONSTER
	else
		return 0
	end
end
