--ターボ・ウォリアー
function c511001941.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--atk down
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511001941.atkcon)
	e1:SetOperation(c511001941.atkop)
	c:RegisterEffect(e1)
end
function c511001941.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return a==c and d and d:IsFaceup() and d:GetAttack()>e:GetHandler():GetAttack()
end
function c511001941.atkop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(Duel.GetAttackTarget():GetAttack()/2)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.GetAttackTarget():RegisterEffect(e1)
end
