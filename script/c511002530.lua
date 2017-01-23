--機皇兵ワイゼル・アイン
function c511002530.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLE_CONFIRM)
	e1:SetCondition(c511002530.con)
	e1:SetOperation(c511002530.op)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	c:RegisterEffect(e1)
end
function c511002530.con(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return Duel.GetAttacker():IsControler(tp) and at and at:IsControler(1-tp) and at:IsDefensePos()
end
function c511002530.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc and tc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_PIERCE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
	end
end
