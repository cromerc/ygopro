---ＲＵＭ－ラプターズ・フォース
function c5629.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c5629.condition)
	e1:SetTarget(c5629.target)
	e1:SetOperation(c5629.operation)
	c:RegisterEffect(e1)
	--
	if not c5629.global_check then
		c5629.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_TO_GRAVE)
		ge1:SetCondition(c5629.con)
		ge1:SetOperation(c5629.op)
		Duel.RegisterEffect(ge1,tp)
	end
end
function c5629.conF(c)
	return c:IsReason(REASON_DESTROY)
	and c:IsType(TYPE_MONSTER)
	and c:IsType(TYPE_XYZ)
	and c:IsSetCard(0xba)
end
function c5629.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c5629.conF,1,nil)
end
function c5629.op(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c5629.conF,nil)
	local sc=g:GetFirst()
	while sc do
		if Duel.GetFlagEffect(sc:GetPreviousControler(),5629)==0 then
			Duel.RegisterFlagEffect(sc:GetPreviousControler(),5629,RESET_PHASE+PHASE_END,0,1)
		end
		--
		sc=g:GetNext()
	end
end	
function c5629.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,5629)~=0
end
function c5629.rumF1(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
		and c:IsType(TYPE_MONSTER)
		and c:IsType(TYPE_XYZ)
		and c:IsSetCard(0xba)
		and Duel.IsExistingMatchingCard(c5629.rumF2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c)
end
function c5629.rumF2(c,e,tp,tc)
	if c:IsCode(6165656) and tc:GetCode()~=48995978 then return false end
	local rk=tc:GetRank()
	return c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
		and c:IsType(TYPE_MONSTER)
		and c:IsType(TYPE_XYZ)
		and c:GetRank()==rk+1
		and c:IsSetCard(0xba)
end
function c5629.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		return c5629.rumF1(chkc)
		and chkc:IsLocation(LOCATION_GRAVE)
		and chkc:IsControler(tp)
	end
	--
	if chk==0 then return Duel.IsPlayerCanSpecialSummonCount(tp,2)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c5629.rumF1,tp,LOCATION_GRAVE,0,1,nil,e,tp)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c5629.rumF1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	Duel.SetOperationInfo(tp,CATEGORY_SPECIAL_SUMMON,tc,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(tp,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c5629.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not Duel.IsPlayerCanSpecialSummonCount(tp,2) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(c5629.rumF2,tp,LOCATION_EXTRA,0,nil,e,tp,tc)
		if g:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,509)
			local tg=g:Select(tp,1,1,nil)
			local sc=tg:GetFirst()
			local pos=POS_FACEUP_ATTACK
			if not tc:IsCanBeSpecialSummoned(e,0,tp,false,false,pos) then
				pos=POS_FACEUP_DEFENCE
			end
			if Duel.SpecialSummon(tc,0,tp,tp,false,false,pos)~=0 then
				local mg=tc:GetOverlayGroup()
				if mg:GetCount()>0 then
					Duel.Overlay(sc,mg)
				end
				Duel.Overlay(sc,tc)
				if Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)~=0 then
					sc:CompleteProcedure()
				end
			end
		end
	end
end	
