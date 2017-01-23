--Joe the Pixie
function c511002935.initial_effect(c)
	--0 damage
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e4:SetCondition(c511002935.atkcon)
	e4:SetOperation(c511002935.atkop)
	c:RegisterEffect(e4)
end
function c511002935.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if not bc or c:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)>0 then return false end
	if c:IsAttackPos() and bc:IsAttackPos() and c:GetAttack()<=bc:GetAttack() then return true end
	if c:IsDefensePos() and c:GetDefense()<bc:GetAttack() then return true end
	return false
end
function c511002935.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(e:GetHandler():GetControler(),0)
end
