--However!
function c511002030.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCondition(c511002030.atkcon)
	e2:SetTarget(c511002030.atktg)
	e2:SetOperation(c511002030.atkop)
	c:RegisterEffect(e2)
end
function c511002030.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if Duel.IsDamageCalculated() then return false end
	local tc=Duel.GetAttacker()
	if not tc then return false end
	if tc:IsControler(1-tp) then tc=Duel.GetAttackTarget() end
	e:SetLabelObject(tc)
	return tc and tc:IsFaceup() and tc:IsSetCard(0x213) and tc:IsRelateToBattle() 
		and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511002030.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=e:GetLabelObject()
	if chkc then return chkc==tc end
	if chk==0 then return tc and tc:IsOnField() and tc:IsCanBeEffectTarget(e) and tc:GetFlagEffect(511002030)==0 end
	Duel.SetTargetCard(tc)
end
function c511002030.atkop(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or not tc or not tc:IsRelateToBattle() or tc:IsFacedown() then return end
	tc:RegisterFlagEffect(511002030,RESET_EVENT+0x1fe0000,0,1)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c511002030.valcon)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_NO_BATTLE_DAMAGE)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	e2:SetValue(1)
	tc:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	e3:SetValue(1)
	tc:RegisterEffect(e3)
end
function c511002030.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
