--Half Life
function c511001592.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511001592.condition)
	e1:SetTarget(c511001592.target)
	e1:SetOperation(c511001592.operation)
	c:RegisterEffect(e1)
end
function c511001592.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	if a:GetAttack()==d:GetAttack() and a:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)>0 and d:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)>0
		and a:IsAttackPos() and d:IsAttackPos() then return false end
	if a:IsAttackPos() and d:IsAttackPos() and a:GetAttack()==d:GetAttack() and a:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)>0 then
		e:SetLabelObject(d)
		return true
	end
	if a:IsAttackPos() and d:IsAttackPos() and a:GetAttack()==d:GetAttack() and d:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)>0 then
		local g=Group.FromCards(a)
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	end
	if a:IsAttackPos() and d:IsAttackPos() and a:GetAttack()==d:GetAttack() and a:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)==0 
		and d:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)==0 then
		local g=Group.FromCards(a,d)
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	end
	if d:IsAttackPos() and a:GetAttack()>d:GetAttack() and d:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)==0 then
		local g=Group.FromCards(d)
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	end
	if d:IsAttackPos() and a:GetAttack()<d:GetAttack() and a:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)==0 then
		local g=Group.FromCards(a)
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	end
	if d:IsDefensePos() and a:GetAttack()>d:GetDefense() and d:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)==0 then
		local g=Group.FromCards(d)
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	end
	return false
end
function c511001592.filter(c)
	return c:GetAttack()>1
end
function c511001592.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetLabelObject()
	if chk==0 then return g:GetCount()>0 and g:IsExists(c511001592.filter,1,nil) end
end
function c511001592.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_ATTACK_FINAL)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(tc:GetAttack()/2)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
