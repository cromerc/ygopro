--Zero Gate of the Void
function c511000793.initial_effect(c)
	--Return
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(511002521)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c511000793.condition)
	e1:SetCost(c511000793.cost)
	e1:SetTarget(c511000793.target)
	e1:SetOperation(c511000793.activate)
	c:RegisterEffect(e1)
	if not c511000793.global_check then
		c511000793.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_CANNOT_LOSE_LP)
		ge1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		ge1:SetTargetRange(1,0)
		ge1:SetLabel(0)
		ge1:SetCondition(c511000793.con)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetLabel(1)
		Duel.RegisterEffect(ge2,1)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_ADJUST)
		ge3:SetOperation(c511000793.op)
		Duel.RegisterEffect(ge3,0)
	end
end
function c511000793.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND+LOCATION_ONFIELD,0)<=0
end
function c511000793.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_CHAIN)
	e1:SetCode(EFFECT_CANNOT_LOSE_LP)
	Duel.RegisterEffect(e1,tp)
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
end
function c511000793.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,81020646,0,0x2021,3000,3000,8,RACE_DRAGON,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_EXTRA)
end
function c511000793.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.CreateToken(tp,81020646)
	if tc and Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)>0 then
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_CANNOT_LOSE_DECK)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetTargetRange(1,0)
		Duel.RegisterEffect(e2,tp)
		local e3=e2:Clone()
		e3:SetCode(EFFECT_CANNOT_LOSE_LP)
		Duel.RegisterEffect(e3,tp)
		local e4=e2:Clone()
		e4:SetLabelObject(tc)
		e4:SetCondition(c511000793.lcon)
		e4:SetCode(EFFECT_CANNOT_LOSE_EFFECT)
		Duel.RegisterEffect(e4,tp)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_DESTROYED)
		e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		e1:SetLabel(1-tp)
		e1:SetLabelObject(e4)
		e1:SetOperation(c511000793.leaveop)
		tc:RegisterEffect(e1)
	end
end
function c511000793.lcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetLabelObject():IsReason(REASON_DESTROY+REASON_FUSION+REASON_SYNCHRO+REASON_XYZ)
end
function c511000793.leaveop(e,tp,eg,ep,ev,re,r,rp)
	local WIN_REASON_ZERO_GATE=0x53
	Duel.Win(e:GetLabel(),WIN_REASON_ZERO_GATE)
end
function c511000793.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(e:GetLabel(),511002521)>0
end
function c511000793.op(e,tp,eg,ep,ev,re,r,rp)
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
