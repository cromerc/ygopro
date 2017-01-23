--Half Guard
function c511002931.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511002931.condition)
	e1:SetTarget(c511002931.target)
	e1:SetOperation(c511002931.operation)
	c:RegisterEffect(e1)
end
function c511002931.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local bc=tc:GetBattleTarget()
	if tc:IsControler(1-tp) then
		tc=Duel.GetAttackTarget()
		bc=Duel.GetAttacker()
	end
	e:SetLabelObject(tc)
	if not tc or not bc or tc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) 
		or not tc:IsPosition(POS_FACEUP_ATTACK) or tc:GetAttack()<800 then return false end
	if bc==Duel.GetAttackTarget() and bc:IsDefensePos() then return false end
	if bc:IsPosition(POS_FACEUP_DEFENSE) and bc==Duel.GetAttacker() then
		if not bc:IsHasEffect(EFFECT_DEFENSE_ATTACK) then return false end
		if bc:IsHasEffect(EFFECT_DEFENSE_ATTACK) then
			if bc:GetEffectCount(EFFECT_DEFENSE_ATTACK)==1 then
				if bc:GetDefense()==tc:GetAttack() and not bc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
					return bc:GetDefense()~=0
				else
					return bc:GetDefense()>=tc:GetAttack()
				end
			elseif bc:IsHasEffect(EFFECT_DEFENSE_ATTACK) then
				if bc:GetAttack()==tc:GetAttack() and not bc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
					return bc:GetAttack()~=0
				else
					return bc:GetAttack()>=tc:GetAttack()
				end
			end
		end
	else
		if bc:GetAttack()==tc:GetAttack() and not bc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
			return bc:GetAttack()~=0
		else
			return bc:GetAttack()>=tc:GetAttack()
		end
	end
end
function c511002931.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return tc end
	Duel.SetTargetCard(tc)
end
function c511002931.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_BATTLED)
		e2:SetOperation(c511002931.op)
		e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e2)
	end
end
function c511002931.op(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.ChangePosition(e:GetHandler(),POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,0,0)
end
