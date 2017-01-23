--Durability (Dragon's Endurance)
function c511002169.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511002169.condition)
	e1:SetCost(c511002169.cost)
	e1:SetTarget(c511002169.target)
	e1:SetOperation(c511002169.activate)
	c:RegisterEffect(e1)
end
function c511002169.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsFaceup() and d:IsRace(RACE_DRAGON)
end
function c511002169.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local d=Duel.GetAttackTarget()
	if chk==0 then return d:GetAttack()>1 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(d:GetAttack()/2)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	d:RegisterEffect(e1)
end
function c511002169.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local d=Duel.GetAttackTarget()
	if chk==0 then return true end
	Duel.SetTargetCard(d)
end
function c511002169.activate(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d and d:IsFaceup() and d:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		d:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		d:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_NO_BATTLE_DAMAGE)
		d:RegisterEffect(e3)
	end
end
