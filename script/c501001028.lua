---炎竜星－シュンゲイ
function c501001028.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(501001028,0))
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CHAIN_UNIQUE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c501001028.spcon)
	e1:SetCost(c501001028.spcos)
	e1:SetTarget(c501001028.sptg)
	e1:SetOperation(c501001028.spop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(501001028,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,0x1c0+TIMING_MAIN_END+TIMING_BATTLE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c501001028.sccon)
	e2:SetTarget(c501001028.sctarg)
	e2:SetOperation(c501001028.scop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BE_MATERIAL)
	e3:SetCondition(c501001028.sxcon)
	e3:SetOperation(c501001028.sxop)
	c:RegisterEffect(e3)
end	
function c501001028.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return Duel.GetFlagEffect(tp,501001028)==0
	and c:IsReason(REASON_DESTROY)
	and c:GetPreviousControler()==tp
	and c:IsPreviousLocation(LOCATION_MZONE)
end
function c501001028.spcos(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.GetFlagEffect(tp,501001028)==0 end
	Duel.RegisterFlagEffect(tp,501001028,RESET_PHASE+PHASE_END,0,1)
end	
function c501001028.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
	and c:GetCode()~=501001028
	and c:IsSetCard(0x9c)
end
function c501001028.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingMatchingCard(c501001028.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(tp,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end	
function c501001028.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c501001028.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()>0 then
		local tg=g:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENCE)
	end
end	
function c501001028.sccon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return not e:GetHandler():IsStatus(STATUS_CHAINING)
	and Duel.GetTurnPlayer()~=tp
	and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_BATTLE or Duel.GetCurrentPhase()==PHASE_MAIN2)
	and (Duel.GetCurrentPhase()~=PHASE_DAMAGE or Duel.GetCurrentPhase()~=PHASE_DAMAGE_CAL)
end
function c501001028.sfilter(c)
	return c:IsFaceup()
	and not c:IsSetCard(0x9c)
end
function c501001028.sctarg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c501001028.sfilter,tp,LOCATION_MZONE,0,nil)
	local sc=mg:GetFirst()
	while sc do
		--
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
		e1:SetValue(1)
		e1:SetLabelObject(sc)
		e1:SetCondition(c501001028.slimit)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		sc:RegisterEffect(e1)
		--
		local flb=sc:GetFlagEffectLabel(sc:GetCode()+100000000)
		if flb==nil then
			sc:RegisterFlagEffect(sc:GetCode()+100000000,RESET_EVENT+0x1fe0000,0,1,1)
		else
			sc:SetFlagEffectLabel(sc:GetCode()+100000000,1)
		end
		--
		sc=mg:GetNext()
	end
	local frag=Duel.IsExistingMatchingCard(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,1,nil,nil)
	local sc=mg:GetFirst()
	while sc do
		local flb=sc:GetFlagEffectLabel(sc:GetCode()+100000000)
		if flb==nil then
			sc:RegisterFlagEffect(sc:GetCode()+100000000,RESET_EVENT+0x1fe0000,0,1,0)
		else
			sc:SetFlagEffectLabel(sc:GetCode()+100000000,0)
		end
		--
		sc=mg:GetNext()
	end
	if chk==0 then return frag end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c501001028.slimit(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local sc=e:GetLabelObject()
	return sc:GetFlagEffectLabel(sc:GetCode()+100000000)==1
end
function c501001028.scop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c501001028.sfilter,tp,LOCATION_MZONE,0,nil)
	local sc=mg:GetFirst()
	while sc do
		--
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
		e1:SetValue(1)
		e1:SetLabelObject(sc)
		e1:SetCondition(c501001028.slimit)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		sc:RegisterEffect(e1)
		--
		local flb=sc:GetFlagEffectLabel(sc:GetCode()+100000000)
		if flb==nil then
			sc:RegisterFlagEffect(sc:GetCode()+100000000,RESET_EVENT+0x1fe0000,0,1,1)
		else
			sc:SetFlagEffectLabel(sc:GetCode()+100000000,1)
		end
		--
		sc=mg:GetNext()
	end
	local g=Duel.GetMatchingGroup(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,nil,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SynchroSummon(tp,sg:GetFirst(),nil)
	end
	local sc=mg:GetFirst()
	while sc do
		local flb=sc:GetFlagEffectLabel(sc:GetCode()+100000000)
		if flb==nil then
			sc:RegisterFlagEffect(sc:GetCode()+100000000,RESET_EVENT+0x1fe0000,0,1,0)
		else
			sc:SetFlagEffectLabel(sc:GetCode()+100000000,0)
		end
		--
		sc=mg:GetNext()
	end
end
function c501001028.sxcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_SYNCHRO
end
function c501001028.sxop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(500)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	rc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENCE)
	rc:RegisterEffect(e2)
	if not rc:IsType(TYPE_EFFECT)
	and rc:IsType(TYPE_SYNCHRO) then
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_CHANGE_TYPE)
		e3:SetValue(TYPE_MONSTER+TYPE_EFFECT+TYPE_SYNCHRO)
		e3:SetReset(RESET_EVENT+0x1ff0000)
		rc:RegisterEffect(e3)
	end
end
