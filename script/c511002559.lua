--Double Tension
function c511002559.initial_effect(c)
	--damage cal
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002559.condition)
	e1:SetOperation(c511002559.activate)
	c:RegisterEffect(e1)
end
function c511002559.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc:IsControler(tp) and tc:GetAttackedCount()==2
end
function c511002559.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if a and a:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(a:GetAttack()*2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		a:RegisterEffect(e1)
	end
end
