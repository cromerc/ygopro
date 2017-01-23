--Plasma Counter
function c511000313.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511000313.condition)
	e1:SetTarget(c511000313.target)
	e1:SetOperation(c511000313.activate)
	c:RegisterEffect(e1)
end
function c511000313.condition(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	local g=Duel.GetDecktopGroup(tp,1)
	return phase==PHASE_DAMAGE and not Duel.IsDamageCalculated()
		and Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()~=nil and Duel.GetAttackTarget():IsCode(83965310)
		and g:GetFirst():GetCode()==100000270 and g:GetFirst():IsFaceup()
end
function c511000313.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
end
function c511000313.activate(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	local a=Duel.GetAttacker()
	if at:IsFaceup() and at:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(a:GetAttack()/2)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		a:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(1500)
		at:RegisterEffect(e2)
	end
end
