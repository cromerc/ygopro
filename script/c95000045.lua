--Action Card - Miracle
function c95000045.initial_effect(c)
	
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetTarget(c95000045.target)
	e1:SetCondition(c95000045.condition)
	e1:SetOperation(c95000045.activate)
	c:RegisterEffect(e1)

	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetCondition(c95000045.handcon)
	c:RegisterEffect(e2)
end
function c95000045.handcon(e)
	return tp~=Duel.GetTurnPlayer()
end
function c95000045.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and a
end
function c95000045.filter(c)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return c==a or c==d
end
function c95000045.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(c95000045.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c95000045.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c95000045.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
		e2:SetCondition(c95000045.rdcon)
		e2:SetOperation(c95000045.rdop)
		e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e2,true)
	end
end
function c95000045.rdcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==e:GetOwnerPlayer()
end
function c95000045.rdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev/2)
end

