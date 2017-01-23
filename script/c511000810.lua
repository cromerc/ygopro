--Jester Puppet King Pantomime
function c511000810.initial_effect(c)
	c:EnableReviveLimit()
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DAMAGE_CALCULATING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c511000810.atkup)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c511000810.ind)
	c:RegisterEffect(e2)
end
function c511000810.atkup(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d or (a~=c and d~=c) then return end
	local tc=c:GetBattleTarget()
	if tc:GetAttack()>c:GetAttack() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetAttack())
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e1)
	end
end
function c511000810.ind2(e,c)
	return c:IsType(TYPE_SYNCHRO)
end
