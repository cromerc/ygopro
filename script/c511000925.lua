--Soul Shield
function c511000925.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCost(c511000925.cost)
	e1:SetCondition(c511000925.condition)
	e1:SetTarget(c511000925.target)
	e1:SetOperation(c511000925.activate)
	c:RegisterEffect(e1)
end
function c511000925.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	if d:IsControler(1-tp) then a,d=d,a end
	if not d or d:IsControler(1-tp) or d:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then return false end
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
function c511000925.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,Duel.GetLP(tp)/2)
end
function c511000925.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return tc end
	Duel.SetTargetCard(tc)
end
function c511000925.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
		Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end
end
