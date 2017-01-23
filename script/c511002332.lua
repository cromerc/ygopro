--Camouflage
function c511002332.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511002332.condition)
	e1:SetOperation(c511002332.activate)
	c:RegisterEffect(e1)
end
function c511002332.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d:IsFaceup() and d:IsLevelBelow(2)
end
function c511002332.activate(e,tp,eg,ep,ev,re,r,rp)
	 Duel.NegateAttack() 
end
