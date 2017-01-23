--Wing Stream
function c511002345.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511002345.condition)
	e1:SetTarget(c511002345.target)
	e1:SetOperation(c511002345.activate)
	c:RegisterEffect(e1)
end
function c511002345.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d or not d:IsRace(RACE_INSECT) or d:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then return false end
	e:SetLabelObject(d)
	if a:IsPosition(POS_FACEUP_DEFENSE) then
		if not a:IsHasEffect(EFFECT_DEFENSE_ATTACK) then return false end
		if a:IsHasEffect(EFFECT_DEFENSE_ATTACK) then
			if a:GetEffectCount(EFFECT_DEFENSE_ATTACK)==1 then
				if d:IsAttackPos() then
					if a:GetDefense()==d:GetAttack() and not d:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
						return a:GetDefense()~=0
					else
						return a:GetDefense()>=d:GetAttack()
					end
				else
					return a:GetDefense()>d:GetDefense()
				end
			elseif a:IsHasEffect(EFFECT_DEFENSE_ATTACK) then
				if d:IsAttackPos() then
					if a:GetAttack()==d:GetAttack() and not a:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
						return a:GetAttack()~=0
					else
						return a:GetAttack()>=d:GetAttack()
					end
				else
					return a:GetAttack()>d:GetDefense()
				end
			end
		end
	else
		if d:IsAttackPos() then
			if a:GetAttack()==d:GetAttack() and not a:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
				return a:GetAttack()~=0
			else
				return a:GetAttack()>=d:GetAttack()
			end
		else
			return a:GetAttack()>d:GetDefense()
		end
	end
end
function c511002345.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return tc and tc:IsAttackAbove(500) end
	Duel.SetTargetCard(tc)
end
function c511002345.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_UPDATE_ATTACK)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		e3:SetValue(-500)
		tc:RegisterEffect(e3)
	end
end
