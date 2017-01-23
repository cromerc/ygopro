--Xyz Weight
function c511001882.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001882.condition)
	e1:SetTarget(c511001882.target)
	e1:SetOperation(c511001882.activate)
	c:RegisterEffect(e1)
end
function c511001882.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsType(TYPE_XYZ) and tc:IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c511001882.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return true end
	Duel.SetTargetCard(tc)
end
function c511001882.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		e1:SetValue(c511001882.atkval)
		tc:RegisterEffect(e1)
	end
end
function c511001882.atkval(e,c)
	return c:GetOverlayCount()*-800
end
