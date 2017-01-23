--�l�N���E�J�I�X
function c511000687.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000687.target)
	e1:SetOperation(c511000687.activate)
	c:RegisterEffect(e1)
	if not c511000687.global_check then
		c511000687.global_check=true
		--register
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_TO_GRAVE)
		ge2:SetOperation(c511000687.regop)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511000687.filter1(c,e,tp)
	return c:IsType(TYPE_XYZ) and c:GetFlagEffect(511000687)~=0
		and Duel.IsExistingMatchingCard(c511000687.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c:GetRank())
end
function c511000687.filter2(c,e,tp,rk)
	return c:GetRank()==rk and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
		and (c:IsSetCard(0x1048) or c:IsSetCard(0x1073) or c:IsCode(511000296))
end
function c511000687.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c511000687.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511000687.filter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511000687.filter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511000687.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000687.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc:GetRank())
	local tg=g:GetFirst()
	if tg and Duel.SpecialSummonStep(tg,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fa0000)
		tg:RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tg:RegisterEffect(e2,true)
		tg:CompleteProcedure()
		Duel.SpecialSummonComplete()
	end
end
function c511000687.regfilter(c)
	return c:IsLocation(LOCATION_GRAVE) and not c:IsReason(REASON_RETURN) and c:IsType(TYPE_XYZ) and c:GetFlagEffect(511000687)==0
end
function c511000687.regop(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	local g=eg:Filter(c511000687.regfilter,nil)
	if g:GetCount()>0 and ph>=0x08 and ph<=0x20 then
		local tc=g:GetFirst()
		while tc do
			tc:RegisterFlagEffect(511000687,RESET_EVENT+0x1fe0000,0,1)
			tc=g:GetNext()
		end
	end
end
