--Crystal Seal
function c511000453.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1c0)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000453.target)
	e1:SetOperation(c511000453.operation)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_ADJUST)
	e2:SetLabelObject(e1)
	e2:SetOperation(c511000453.desop)
	c:RegisterEffect(e2)
	--indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(c511000453.indval)
	c:RegisterEffect(e3)
end
function c511000453.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511000453.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetCondition(c511000453.rcon)
		tc:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_ATTACK)
		tc:RegisterEffect(e2,true)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_UNRELEASABLE_SUM)
		e3:SetValue(1)
		tc:RegisterEffect(e3,true)
		local e4=e3:Clone()
		e4:SetCode(EFFECT_UNRELEASABLE_NONSUM)
		tc:RegisterEffect(e4,true)
		local e5=e1:Clone()
		e5:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		tc:RegisterEffect(e5,true)
		local e6=e3:Clone()
		e6:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
		tc:RegisterEffect(e6,true)
		local e7=Effect.CreateEffect(c)
		e7:SetType(EFFECT_TYPE_FIELD)
		e7:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE)
		e7:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
		e7:SetRange(LOCATION_MZONE)
		e7:SetReset(RESET_EVENT+0x1fe0000)
		e7:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		e7:SetTarget(c511000453.cfilter)
		tc:RegisterEffect(e7,true)
		e:SetLabel(tc:GetAttack())
	end
end
function c511000453.efilter(e,re,rp)
	return e:GetHandlerPlayer()~=rp
end
function c511000453.cfilter(e,c)
	return c==e:GetHandler()
end
function c511000453.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
function c511000453.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetFirstCardTarget()
	if not tc then return end
	if e:GetLabelObject():GetLabel()~=tc:GetAttack() then
		if e:GetLabelObject():GetLabel()<tc:GetAttack() then
			Duel.Destroy(e:GetHandler(),REASON_EFFECT)
		else
			e:GetLabelObject():SetLabel(tc:GetAttack())
		end
	end
end
function c511000453.indval(e,re,tp)
	return e:GetOwner()~=re:GetOwner()
end
