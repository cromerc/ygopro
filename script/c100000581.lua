--ランクアップ・スパイダーウェブ
function c100000581.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Rank-Up
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c100000581.target)
	e2:SetOperation(c100000581.activate)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetOperation(c100000581.sdesop)
	c:RegisterEffect(e3)
end
function c100000581.filter1(c,e,tp)
	local rk=c:GetRank()
	return rk>0 and c:IsFaceup() and c:CheckRemoveOverlayCard(tp,1,REASON_EFFECT)
	and Duel.IsExistingMatchingCard(c100000581.filter2,tp,LOCATION_EXTRA,0,1,nil,rk,e,tp)
end
function c100000581.filter2(c,rk,e,tp)
	return c:GetRank()==rk+1 and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c100000581.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c100000581.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c100000581.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c100000581.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c100000581.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	tc:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000581.filter2,tp,LOCATION_EXTRA,0,1,1,nil,tc:GetRank(),e,tp)
	local sc=g:GetFirst()
	if sc then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		Duel.Overlay(sc,Group.FromCards(tc))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
		e:GetHandler():RegisterFlagEffect(100000581,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END,0,0)
	end
end
function c100000581.sdesop(e,tp,eg,ep,ev,re,r,rp)
	if tp~=Duel.GetTurnPlayer() then return end
	if e:GetHandler():GetFlagEffect(100000581)==0 then
		local c=e:GetHandler()
		Duel.Destroy(c,REASON_EFFECT)
	end
end