--Water Barrier
function c511002847.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002847.condition)
	e1:SetOperation(c511002847.activate)
	c:RegisterEffect(e1)
end
function c511002847.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return Duel.GetAttacker():IsControler(1-tp) and at and at:IsFaceup() and at:IsAttribute(ATTRIBUTE_WATER)
end
function c511002847.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end	