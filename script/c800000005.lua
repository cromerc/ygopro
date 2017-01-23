-- Antlion
-- scripted by: UnknownGuest
function c800000005.initial_effect(c)
	-- atkdown
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCondition(c800000005.condition)
	e1:SetTarget(c800000005.target)
	e1:SetOperation(c800000005.operation)
	c:RegisterEffect(e1)
end
function c800000005.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetAttackTarget()==e:GetHandler() and (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL)
end
function c800000005.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttacker():IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(Duel.GetAttacker())
end
function c800000005.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(-500)
		tc:RegisterEffect(e1)
	end
end