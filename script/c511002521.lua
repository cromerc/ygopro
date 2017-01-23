--Relay Soul (Anime)
--By Edo9300
--Cleaned Up and Fixed by MLD
function c511002521.initial_effect(c)
	--Survive
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(511002521)
	e1:SetCost(c511002521.cost)
	e1:SetTarget(c511002521.target)
	e1:SetOperation(c511002521.activate)
	c:RegisterEffect(e1)
	if not c511002521.global_check then
		c511002521.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_CANNOT_LOSE_LP)
		ge1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		ge1:SetTargetRange(1,0)
		ge1:SetLabel(0)
		ge1:SetCondition(c511002521.con2)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetLabel(1)
		Duel.RegisterEffect(ge2,1)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_ADJUST)
		ge3:SetOperation(c511002521.op)
		Duel.RegisterEffect(ge3,0)
	end
end
function c511002521.con2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(e:GetLabel(),511002521)>0
end
function c511002521.op(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	if Duel.GetLP(0)<=0 and ph~=PHASE_DAMAGE then
		Duel.RaiseEvent(Duel.GetMatchingGroup(nil,0,0xff,0,nil),511002521,e,0,0,0,0)
		Duel.ResetFlagEffect(0,511002521)
	end
	if Duel.GetLP(1)<=0 and ph~=PHASE_DAMAGE then
		Duel.RaiseEvent(Duel.GetMatchingGroup(nil,1,0xff,0,nil),511002521,e,0,0,0,0)
		Duel.ResetFlagEffect(1,511002521)
	end
	if Duel.GetLP(0)>0 and Duel.GetFlagEffect(0,511002521)==0 then
		Duel.RegisterFlagEffect(0,511002521,0,0,1)
	end
	if Duel.GetLP(1)>0 and Duel.GetFlagEffect(1,511002521)==0 then
		Duel.RegisterFlagEffect(1,511002521,0,0,1)
	end
end
function c511002521.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_CHAIN)
	e1:SetCode(EFFECT_CANNOT_LOSE_LP)
	Duel.RegisterEffect(e1,e:GetHandlerPlayer())
end
function c511002521.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002521.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511002521.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511002521.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=e:GetHandlerPlayer()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002521.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_BE_MATERIAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e1:SetLabel(tp)
		e1:SetCondition(c511002521.matcon)
		e1:SetOperation(c511002521.matop)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_CANNOT_LOSE_DECK)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetTargetRange(1,0)
		e2:SetLabel(1)
		e2:SetLabelObject(tc)
		e2:SetCondition(c511002521.con)
		Duel.RegisterEffect(e2,tp)
		local e3=e2:Clone()
		e3:SetCode(EFFECT_CANNOT_LOSE_LP)
		Duel.RegisterEffect(e3,tp)
		local e4=e2:Clone()
		e4:SetCode(EFFECT_CANNOT_LOSE_EFFECT)
		tc:RegisterEffect(e4)
		Duel.RegisterEffect(e4,tp)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_LEAVE_FIELD)
		e3:SetLabel(1-tp)
		e3:SetCondition(c511002521.losecon)
		e3:SetOperation(c511002521.loseop)
		e3:SetReset(RESET_EVENT+0xc020000)
		tc:RegisterEffect(e3,true)
		Duel.SpecialSummonComplete()
	end
end
function c511002521.losecon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY)
end
function c511002521.loseop(e,tp,eg,ep,ev,re,r,rp)
	local WIN_REASON_RELAY_SOUL=0x1a
	Duel.Win(e:GetLabel(),WIN_REASON_RELAY_SOUL)
end
function c511002521.con(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject() and e:GetLabelObject():IsLocation(LOCATION_ONFIELD) then
		return true
	end
	if e:GetLabel()==0 then
		e:SetLabelObject(nil)
		return false
	else
		e:SetLabel(0)
	end
	return false
end
function c511002521.matcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_SYNCHRO or r==REASON_XYZ or r==REASON_FUSION
end
function c511002521.matop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=e:GetLabel()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetLabel(tp)
	e1:SetCondition(c511002521.matcon)
	e1:SetOperation(c511002521.matop)
	rc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_LOSE_DECK)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetLabelObject(rc)
	e2:SetLabel(1)
	e2:SetCondition(c511002521.con)
	Duel.RegisterEffect(e2,tp)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_LOSE_LP)
	Duel.RegisterEffect(e3,tp)
	local e4=e2:Clone()
	e4:SetCode(EFFECT_CANNOT_LOSE_EFFECT)
	Duel.RegisterEffect(e4,tp)
end
