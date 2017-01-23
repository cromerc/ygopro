--Binding Swords of Impact
function c511009374.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511009374.cost)
	e1:SetCondition(c511009374.condition)
	e1:SetTarget(c511009374.target)
	e1:SetOperation(c511009374.operation)
	c:RegisterEffect(e1)	
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(40854197,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c511009374.leavecon)
	e2:SetOperation(c511009374.leaveop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_REMOVE)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e4)
	--cannot attack
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	c:RegisterEffect(e5)
		--damage reduce
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_CHANGE_DAMAGE)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetRange(LOCATION_MZONE)
	e6:SetTargetRange(1,1)
	e6:SetValue(c511009374.damval)
	c:RegisterEffect(e6)
	--act in hand
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e7:SetCondition(c511009374.handcon)
	c:RegisterEffect(e7)
end
function c511009374.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_HAND) and (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE)
end
function c511009374.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>1 end
	local g=Duel.GetFieldGroup(p,LOCATION_HAND,0)
	Debug.Message(g:GetCount())
	e:SetLabel(count)
	Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
end
function c511009374.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	-- Debug.Message(e:GetLabel())
	--destroy
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCondition(c511009374.descon)
	e1:SetLabel(e:GetLabel())
	e1:SetOperation(c511009374.desop)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_OPPO_TURN,e:GetLabel())
	e:GetHandler():RegisterEffect(e1)
end
function c511009374.operation(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():SetTurnCounter(0)
end
function c511009374.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511009374.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	Debug.Message(e:GetLabel())
	if ct==e:GetLabel() then
		Duel.Destroy(c,REASON_RULE)
	end
end
function c511009374.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 then return 0 end
	return val
end
function c511009374.leavecon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c511009374.leaveop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_SKIP_DP)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END,3)
	Duel.RegisterEffect(e1,tp)
end
function c511009374.handcon(e)
	return true
end
