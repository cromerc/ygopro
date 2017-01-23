--Magnet Force Plus
function c170000122.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c170000122.target)
	e1:SetOperation(c170000122.operation)
	c:RegisterEffect(e1)
end
function c170000122.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c170000122.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsLocation(LOCATION_SZONE) then return end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		if not Duel.Equip(tp,c,tc) then return end
		c:CancelToGrave()
		--Equip limit
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
		e2:SetValue(c170000122.vala)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
		--must attack
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_EQUIP)
		e3:SetCode(EFFECT_MUST_ATTACK)
		e3:SetCondition(c170000122.becon)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e3)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_FIELD)
		e4:SetCode(EFFECT_CANNOT_EP)
		e4:SetRange(LOCATION_SZONE)
		e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e4:SetTargetRange(0,1)
		e4:SetCondition(c170000122.becon)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e4)
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_FIELD)
		e5:SetCode(EFFECT_MUST_BE_ATTACKED)
		e5:SetTargetRange(LOCATION_MZONE,0)
		e5:SetRange(LOCATION_SZONE)
		e5:SetValue(c170000122.atkval)
		e5:SetTarget(c170000122.atktg)
		e5:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e5)
	end
end
function c170000122.vala(e,c)
	return c:IsFaceup() and c:IsType(0x20000000) and not c:IsType(0x40000000)
end
function c170000122.atkfilter(c)
	return c:IsFaceup() and c:IsType(0x40000000)
end
function c170000122.becon(e)
	return e:GetHandler():GetEquipTarget():IsAttackable() 
		and Duel.IsExistingMatchingCard(c170000122.atkfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c170000122.atktg(e,c)
	return c:IsFaceup() and c:IsType(0x40000000)
end
function c170000122.atkval(e,c)
	return not c:IsImmuneToEffect(e) and c==e:GetHandler():GetEquipTarget()
end
