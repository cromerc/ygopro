--Adversity
--scripted by: UnknownGuest
function c810000115.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c810000115.condition)
	e1:SetOperation(c810000115.operation)
	c:RegisterEffect(e1)
end
function c810000115.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local a=Duel.GetAttacker()
	local atk=a:GetAttack()
	return tc:IsControler(tp) and tc:GetAttack()<atk
end
function c810000115.operation(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if not d:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	d:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	d:RegisterEffect(e2)
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_SINGLE)
	--e3:SetProperty(EFFECT_FLAG_OWNER_RELATE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(1000)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	d:RegisterEffect(e3)
end