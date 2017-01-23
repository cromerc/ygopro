--Banishing Climb
function c511000975.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000975.condition)
	e1:SetTarget(c511000975.target)
	e1:SetOperation(c511000975.activate)
	c:RegisterEffect(e1)
end
function c511000975.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
end
function c511000975.filter(c)
	return c:GetTurnID()==Duel.GetTurnCount() and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)~=0
		and c:IsType(TYPE_SYNCHRO) and c:IsFaceup() and c:IsAbleToRemove()
end
function c511000975.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000975.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c511000975.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c511000975.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511000975.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if Duel.Remove(g,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local og=Duel.GetOperatedGroup()
		local oc=og:GetFirst()
		while oc do
			oc:RegisterFlagEffect(511000975,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
			oc=og:GetNext()
		end
		og:KeepAlive()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
		e1:SetReset(RESET_PHASE+PHASE_BATTLE)
		e1:SetCountLimit(1)
		e1:SetLabelObject(og)
		e1:SetOperation(c511000975.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511000975.retfilter(c)
	return c:GetFlagEffect(511000975)~=0
end
function c511000975.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local sg=g:Filter(c511000975.retfilter,nil)
	g:DeleteGroup()
	local tc=sg:GetFirst()
	while tc do
		if Duel.ReturnToField(tc) and tc:IsFaceup() then
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e2)
			local e3=Effect.CreateEffect(e:GetHandler())
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_DISABLE_EFFECT)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e3)
		end
		tc:SetStatus(STATUS_SUMMON_TURN+STATUS_FORM_CHANGED,false)
		tc=sg:GetNext()
	end
end
