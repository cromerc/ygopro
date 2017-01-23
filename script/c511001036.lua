--Stone Bola
function c511001036.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001036.condition)
	e1:SetTarget(c511001036.target)
	e1:SetOperation(c511001036.activate)
	c:RegisterEffect(e1)
end
function c511001036.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511001036.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c511001036.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if Duel.NegateAttack() then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_ATTACK)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetLabel(Duel.GetTurnCount())
			e1:SetCondition(c511001036.skipcon)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE+RESET_SELF_TURN,2)
			tc:RegisterEffect(e1,true)
		end
	end
end
function c511001036.skipcon(e)
	return Duel.GetTurnCount()~=e:GetLabel()
end
