--Unbroken Atmosphere
function c511002299.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002299.condition)
	e1:SetOperation(c511002299.activate)
	c:RegisterEffect(e1)
end
function c511002299.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttackTarget()
	return a and a:IsFaceup() and (a:IsCode(511002289) or a:IsCode(511002290) or a:IsCode(14466224) or a:IsCode(72144675) 
		or a:IsCode(66094973) or a:IsCode(511002291) or a:IsCode(511002292)) and a:IsControler(tp)
end
function c511002299.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
