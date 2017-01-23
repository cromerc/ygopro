--Invincible Hero
function c511001332.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511001332.activate)
	c:RegisterEffect(e1)
end
function c511001332.activate(e,tp,eg,ep,ev,re,r,rp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetCondition(c511001332.condition)
	e2:SetValue(1)
	Duel.RegisterEffect(e2,tp)
end
function c511001332.condition(e)
	return Duel.GetAttackTarget() and Duel.GetAttackTarget():IsControler(e:GetHandler():GetControler())
end
