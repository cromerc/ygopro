--Celestial Tuner
function c511000798.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure2(c,nil,aux.NonTuner(nil))
	c:EnableReviveLimit()
	--cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c511000798.notatk)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EFFECT_SET_ATTACK_FINAL)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511000798.condition)
	e2:SetValue(c:GetAttack()*2)
	c:RegisterEffect(e2)
end
function c511000798.notatk(e,c)
	return not c:IsType(TYPE_SYNCHRO)
end
function c511000798.condition(e)
	local phase=Duel.GetCurrentPhase()
	return (phase==PHASE_DAMAGE or phase==PHASE_DAMAGE_CAL) and Duel.GetAttackTarget()~=nil
end
