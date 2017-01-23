--Pump Action Commando
function c511002231.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c511002231.condtion)
	e1:SetValue(400)
	c:RegisterEffect(e1)
end
function c511002231.condtion(e)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) and a and a==e:GetHandler() and d and d:IsControler(1-e:GetHandlerPlayer())
end
