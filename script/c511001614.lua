--Spirit Xyz Spark
function c511001614.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511001614.condition)
	e1:SetTarget(c511001614.target)
	e1:SetOperation(c511001614.operation)
	c:RegisterEffect(e1)
end
function c511001614.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511001614.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511001614.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001614.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001614.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511001614.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001614.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(tc:GetAttack()*2)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_DESTROYED)
		e2:SetProperty(EFFECT_FLAG_DELAY)
		e2:SetCondition(c511001614.drcon)
		e2:SetOperation(c511001614.drop)
		e2:SetReset(RESET_EVENT+0x1100000)
		tc:RegisterEffect(e2)
	end
end
function c511001614.drcon(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and not e:GetHandler():IsReason(REASON_BATTLE)
end
function c511001614.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
end
