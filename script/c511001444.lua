--Stop Hammer
function c511001444.initial_effect(c)
	--disable attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(82593786,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_BATTLE_PHASE)
	e1:SetCondition(c511001444.condition)
	e1:SetOperation(c511001444.operation)
	c:RegisterEffect(e1)
end
function c511001444.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()~=nil
end
function c511001444.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-500)
		Duel.GetAttacker():RegisterEffect(e1)
	end
end
