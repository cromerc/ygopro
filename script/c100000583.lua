--ＲＵＭ－七皇の剣
function c100000583.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c100000583.target)
	e1:SetOperation(c100000583.activate)
	c:RegisterEffect(e1)
end
function c100000583.filter1(c,e,tp)
	local no=c.xyz_number
	local rk=c:GetRank()
	local code=c:GetCode()
	return no and no>=101 and no<=107 and c:IsSetCard(0x48) and not c:IsSetCard(0x1048)
	and Duel.IsExistingMatchingCard(c100000583.filter2,tp,LOCATION_EXTRA,0,1,nil,rk+1,e,tp,c:GetCode()) 
	and ((c:GetLocation()==LOCATION_MZONE and c:IsFaceup()) 
	or ((c:GetLocation()==LOCATION_EXTRA or (c:GetLocation()==LOCATION_GRAVE) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)) 
	and c:IsCanBeSpecialSummoned(e,0,tp,true,false)))
end
function c100000583.filter2(c,rk,e,tp,code)
    if c:IsCode(6165656) and code~=48995978 then return false end
	return c:GetRank()==rk  and (c:IsSetCard(0x1048) or c:IsSetCard(0x1073))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c100000583.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE+LOCATION_EXTRA) and c100000583.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c100000583.filter1,tp,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c100000583.filter1,tp,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_EXTRA,0,1,1,nil,e,tp)
	Duel.ConfirmCards(1-tp,g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c100000583.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	if tc:IsLocation(LOCATION_GRAVE+LOCATION_EXTRA) then
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2,true)
		Duel.SpecialSummonComplete()
		Duel.BreakEffect()
		if not Duel.IsExistingMatchingCard(c100000583.filter2,tp,LOCATION_EXTRA,0,1,nil,tc:GetRank()+1,e,tp) then return end
	else
		if tc:IsFacedown() or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000583.filter2,tp,LOCATION_EXTRA,0,1,1,nil,tc:GetRank()+1,e,tp,tc:GetCode())
	local sc=g:GetFirst()
	if sc then
		
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		Duel.Overlay(sc,Group.FromCards(tc))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
