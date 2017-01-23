--Tidal Advantage
function c511001360.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511001360.condition)
	e1:SetOperation(c511001360.activate)
	c:RegisterEffect(e1)
end
function c511001360.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and ((d:IsAttribute(ATTRIBUTE_WATER) and d:IsControler(tp)) or (a:IsAttribute(ATTRIBUTE_WATER) and a:IsControler(tp)))
end
function c511001360.activate(e,tp,eg,ep,ev,re,r,rp)
	local s=Duel.GetAttacker()
	local o=Duel.GetAttackTarget()
	if o:IsAttribute(ATTRIBUTE_WATER) and o:IsControler(tp) then s,o=o,s end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(o:GetAttack()/2)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	o:RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetTarget(c511001360.filter)
	e2:SetValue(1)
	Duel.RegisterEffect(e2,tp)
end
function c511001360.filter(e,c)
	return c:IsAttribute(ATTRIBUTE_WATER)
end
