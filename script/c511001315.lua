--Attrition
function c511001315.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--lose atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511001315.condition)
	e2:SetOperation(c511001315.activate)
	c:RegisterEffect(e2)
end
function c511001315.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	if not at then return false end
	if at:IsControler(tp) then at=Duel.GetAttacker() end
	return at and at:IsRelateToBattle() and not at:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c511001315.activate(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	if at:IsControler(tp) then at=Duel.GetAttacker() end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(-ev)
	at:RegisterEffect(e1)
end
