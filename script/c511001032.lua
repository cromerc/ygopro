--Chronomaly Ley Line Power
function c511001032.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_CAL)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(c511001032.condition)
	e1:SetOperation(c511001032.activate)
	c:RegisterEffect(e1)
	if not c511001032.global_check then
		c511001032.global_check=true
		local sp=Effect.CreateEffect(c)
		sp:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		sp:SetCode(EVENT_SPSUMMON_SUCCESS)
		sp:SetOperation(c511001032.op)
		Duel.RegisterEffect(sp,0)
	end
end
function c511001032.op(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	if ph>=0x08 and ph<=0x20 then
		local g=eg:GetFirst()
		while g do
			g:RegisterFlagEffect(511001032,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,0)
			g=eg:GetNext()
		end
	end
end
function c511001032.filter(c)
	return c:GetFlagEffect(511001032)>0 and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)~=0 and c:IsFaceup()
end
function c511001032.condition(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if (phase~=PHASE_DAMAGE and phase~=PHASE_DAMAGE_CAL) or Duel.IsDamageCalculated() then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return a:IsRelateToBattle() and d and d:IsRelateToBattle() and (c511001032.filter(a) or c511001032.filter(d))
end
function c511001032.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if a and a:IsRelateToBattle() and d and d:IsRelateToBattle() then
		local aatk=a:GetAttack()
		local datk=d:GetAttack()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(datk)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		a:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_ATTACK_FINAL)
		e2:SetValue(aatk)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		d:RegisterEffect(e2)
	end
end
