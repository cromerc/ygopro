--Power Annihilator
function c511001378.initial_effect(c)
	--atkdef up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001378,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511001378.con)
	e1:SetOperation(c511001378.op)
	c:RegisterEffect(e1)
end
function c511001378.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:GetAttack()~=c:GetAttack()
end
function c511001378.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and bc then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		if bc:GetAttack()>c:GetAttack() then
			e1:SetValue(1000)
		elseif c:GetAttack()>bc:GetAttack() then
			e1:SetValue(-1000)
		else
			e1:SetValue(0)
		end
		c:RegisterEffect(e1)
	end
end
