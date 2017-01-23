--Cipher Interfere
function c511009133.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCondition(c511009133.atkcon)
	e2:SetCountLimit(1)
	e2:SetTarget(c511009133.atktg)
	e2:SetOperation(c511009133.atkop)
	c:RegisterEffect(e2)
end
function c511009133.filter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c511009133.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if Duel.IsDamageCalculated() then return false end
	local tc=Duel.GetAttacker()
	if not tc then return false end
	if tc:IsControler(1-tp) then 
		tc=Duel.GetAttackTarget() 
	end
	e:SetLabelObject(tc)
	return tc and tc:IsFaceup() and tc:IsSetCard(0xe5) and tc:IsRelateToBattle()
	and Duel.IsExistingMatchingCard(c511009133.filter,0,LOCATION_MZONE,LOCATION_MZONE,1,tc,tc:GetCode())
		and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511009133.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=e:GetLabelObject()
	if chkc then return chkc==tc end
	if chk==0 then return tc and tc:IsOnField() and tc:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tc)
end
function c511009133.atkop(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or not tc or not tc:IsRelateToBattle() or tc:IsFacedown() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	e1:SetValue(tc:GetAttack()*2)
	tc:RegisterEffect(e1)
end

