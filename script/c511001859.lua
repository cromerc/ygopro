--Prevent Reborn
function c511001859.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511001859.condition)
	e1:SetOperation(c511001859.operation)
	c:RegisterEffect(e1)
end
function c511001859.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local bc=tc:GetBattleTarget()
	if tc:IsControler(1-tp) then
		tc=Duel.GetAttackTarget()
		bc=Duel.GetAttacker()
	end
	if not tc or not bc or tc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) 
		or not tc:IsPosition(POS_FACEUP_ATTACK) then return false end
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
function c511001859.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511001859.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	e2:SetOperation(c511001859.spop)
	Duel.RegisterEffect(e2,tp)
end
function c511001859.damop(e,tp,eg,ep,ev,re,r,rp)
	local dam=ev-1000
	if dam<0 then dam=0 end
	Duel.ChangeBattleDamage(tp,dam)
end
function c511001859.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsLocation(LOCATION_MZONE)
end
function c511001859.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.FromCards(Duel.GetAttacker(),Duel.GetAttackTarget()):Filter(c511001859.filter,nil,e,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or g:GetCount()<=0 then return end
	if g:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		g=g:Select(tp,1,1,nil)
	end
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
