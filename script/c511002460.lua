--Shadow Shield
function c511002460.initial_effect(c)
	--change battle target
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79997591,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511002460.condition)
	e1:SetOperation(c511002460.activate)
	c:RegisterEffect(e1)
end
function c511002460.condition(e,tp,eg,ep,ev,re,r,rp)
	local bt=Duel.GetAttackTarget()
	return bt and bt:IsControler(tp)
end
function c511002460.activate(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	local bt=Duel.GetAttackTarget()
	if not (bt:IsRelateToBattle() and bt:IsControler(tp)) then return end
	if at:IsAttackable() and not at:IsStatus(STATUS_ATTACK_CANCELED) then
		Duel.ChangeAttackTarget(nil)
	end
end
