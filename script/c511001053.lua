--Phantom Sword
function c511001053.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1c0)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetTarget(c511001053.target)
	e1:SetOperation(c511001053.operation)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c511001053.descon)
	e2:SetOperation(c511001053.desop)
	c:RegisterEffect(e2)
end
function c511001053.filter(c)
	return c:IsFaceup() and (c:IsSetCard(0x10d9) or c:IsCode(77462146))
end
function c511001053.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001053.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001053.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511001053.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001053.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(800)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetCondition(c511001053.rcon)
		tc:RegisterEffect(e1,true)
		--Save Monster
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e3:SetCode(EFFECT_DESTROY_REPLACE)
		e3:SetTarget(c511001053.desreptg)
		e3:SetOperation(c511001053.desrepop)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e3)
	end
end
function c511001053.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
function c511001053.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c511001053.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c511001053.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=c:GetFirstCardTarget()
	if chk==0 then return c and not c:IsStatus(STATUS_DESTROY_CONFIRMED)
		and tc and tc:IsReason(REASON_BATTLE) end
	return Duel.SelectYesNo(tp,aux.Stringid(511001053,0))
end
function c511001053.desrepop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.SendtoGrave(c,REASON_EFFECT)
end
