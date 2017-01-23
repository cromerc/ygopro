--Compensation Exchange
function c511001739.initial_effect(c)
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511001739.condition)
	e1:SetTarget(c511001739.target)
	e1:SetOperation(c511001739.operation)
	c:RegisterEffect(e1)
end
function c511001739.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp)
end
function c511001739.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttackTarget() end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,Duel.GetAttackTarget():GetAttack())
end
function c511001739.operation(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d and Duel.NegateAttack() then
		if d:IsFacedown() then Duel.ConfirmCards(1-tp,d) end
		Duel.Damage(tp,d:GetAttack(),REASON_EFFECT)
	end
end
