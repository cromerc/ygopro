--Ｆａｉｒｙ Ｔａｌｅ第三章 黄昏の夕日
function c100000332.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_BOTH_SIDE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c100000332.sptg)
	e2:SetOperation(c100000332.spop)
	c:RegisterEffect(e2)
	--unnegatable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PREDRAW)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e3:SetCondition(c100000332.accon)
	e3:SetOperation(c100000332.acop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	c:RegisterEffect(e4)
	if not c100000332.global_check then
		c100000332.global_check=true
		--check obsolete ruling
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DRAW)
		ge1:SetOperation(c100000332.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c100000332.checkop(e,tp,eg,ep,ev,re,r,rp)
	if bit.band(r,REASON_RULE)~=0 and Duel.GetTurnCount()==1 then
		--obsolete
		Duel.RegisterFlagEffect(tp,62765383,0,0,1)
		Duel.RegisterFlagEffect(1-tp,62765383,0,0,1)
	end
end
function c100000332.filter(c,tp)
	return c:IsCode(100000333) and c:GetActivateEffect():IsActivatable(tp)
end
function c100000332.accon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and e:GetHandler():GetTurnID()~=Duel.GetTurnCount()
end
function c100000332.acop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local tc=Duel.SelectMatchingCard(tp,c100000332.filter,tp,0x13,0,1,1,nil,tp):GetFirst()
	if tc then
		local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
		if Duel.GetFlagEffect(tp,62765383)>0 then
			if fc then Duel.Destroy(fc,REASON_RULE) end
			of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
			if fc and Duel.Destroy(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
		else
			Duel.GetFieldCard(tp,LOCATION_SZONE,5)
			if fc and Duel.SendtoGrave(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
		end
		Duel.BreakEffect()
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.RaiseEvent(tc,EVENT_CHAIN_SOLVED,tc:GetActivateEffect(),0,tp,tp,Duel.GetCurrentChain())
	end
end
function c100000332.spfilter(c,e,tp)
	return c:IsType(TYPE_SYNCHRO) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000332.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c100000332.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c100000332.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c100000332.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c100000332.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
