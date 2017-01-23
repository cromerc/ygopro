--Star Excursion
function c511000873.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511000873.rmcon)
	e1:SetTarget(c511000873.rmtg)
	e1:SetOperation(c511000873.rmop)
	c:RegisterEffect(e1)
end
function c511000873.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	return at and a:IsType(TYPE_SYNCHRO) and at:IsType(TYPE_SYNCHRO)
end
function c511000873.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	if chk==0 then return at and a:IsAbleToRemove() and at:IsAbleToRemove() end
	local g=Group.FromCards(a,at)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,2,0,0)
end
function c511000873.rmop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	local g=Group.FromCards(a,at)
	if Duel.Remove(g,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local og=Duel.GetOperatedGroup()
		local oc=og:GetFirst()
		while oc do
			if oc:GetControler()==tp then
				oc:RegisterFlagEffect(511000873,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE+RESET_OPPO_TURN,0,4)
			else
				oc:RegisterFlagEffect(511000873,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE+RESET_SELF_TURN,0,4)
			end
			oc=og:GetNext()
		end
		og:KeepAlive()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
		if Duel.GetTurnPlayer()~=tp then
			e1:SetReset(RESET_PHASE+PHASE_BATTLE+RESET_OPPO_TURN,4)
			e1:SetLabel(-1)
		else
			e1:SetReset(RESET_PHASE+PHASE_BATTLE+RESET_OPPO_TURN,3)
			e1:SetLabel(0)
		end
		e1:SetCountLimit(1)
		e1:SetLabelObject(og)
		e1:SetOperation(c511000873.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511000873.retfilter(c)
	return c:GetFlagEffect(511000873)~=0
end
function c511000873.retop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	if Duel.GetTurnPlayer()~=tp then
		ct=ct+1
		e:SetLabel(ct)
		if ct>=3 then
			local g=e:GetLabelObject()
			local sg=g:Filter(c511000873.retfilter,nil)
			g:DeleteGroup()
			local tc=sg:GetFirst()
			while tc do
				Duel.ReturnToField(tc)
				tc:SetStatus(STATUS_SUMMON_TURN+STATUS_FORM_CHANGED,false)
				tc=sg:GetNext()
			end
		end
	end
end
