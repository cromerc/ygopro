--RUM－レヴォリューション・フォース
function c511002590.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511002590.target)
	e1:SetOperation(c511002590.activate)
	c:RegisterEffect(e1)
end
function c511002590.filter(c,e,tp)
	local rk=c:GetRank()
	return rk>0 and c:IsFaceup() and c:IsControlerCanBeChanged()
		and Duel.IsExistingMatchingCard(c511002590.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,rk+1,c:GetCode())
end
function c511002590.spfilter(c,e,tp,mc,rk,code)
	if c.rum_limit_code and code~=c.rum_limit_code then return false end
	return c:GetRank()==rk and c:IsSetCard(0xba) and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c511002590.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c511002590.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511002590.filter,tp,0,LOCATION_MZONE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511002590.filter,tp,0,LOCATION_MZONE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511002590.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsFaceup() then return end
	if not Duel.GetControl(tc,tp) then return end
	Duel.BreakEffect()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002590.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc,tc:GetRank()+1,tc:GetCode())
	local sc=g:GetFirst()
	if sc then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.SendtoGrave(mg,REASON_RULE)
		end
		sc:SetMaterial(Group.FromCards(tc))
		Duel.Overlay(sc,Group.FromCards(tc))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
