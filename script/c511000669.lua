--Magic-Reflection Armor - Metal Plus
function c511000669.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000669.target)
	e1:SetOperation(c511000669.operation)
	c:RegisterEffect(e1)
end
function c511000669.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000669.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsLocation(LOCATION_SZONE) then return end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
		c:CancelToGrave()
		--Equip limit
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		--disable
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_DISABLE)
		e2:SetRange(LOCATION_SZONE)
		e2:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
		e2:SetTarget(c511000669.distg)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
		--disable effect
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_CHAIN_SOLVING)
		e3:SetRange(LOCATION_SZONE)
		e3:SetOperation(c511000669.disop)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e3)
		--self destroy
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_FIELD)
		e4:SetCode(EFFECT_SELF_DESTROY)
		e4:SetRange(LOCATION_SZONE)
		e4:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
		e4:SetTarget(c511000669.distg)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e4)
		--disable effect
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e5:SetCode(EVENT_CHAINING)
		e5:SetRange(LOCATION_SZONE)
		e5:SetOperation(c511000669.disop)
		e5:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e5)
	end
end
function c511000669.cfilter(c,tp,eq)
	return c:IsFaceup() and c==eq and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
end
function c511000669.distg(e,c)
	return c:GetCardTargetCount()>0 and c:IsType(TYPE_SPELL)
		and c:GetCardTarget():IsExists(c511000669.cfilter,1,nil,e:GetHandlerPlayer(),e:GetHandler():GetEquipTarget())
end
function c511000669.disop(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsActiveType(TYPE_SPELL) then return end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or not g:IsExists(c511000669.cfilter,1,nil,tp,e:GetHandler():GetEquipTarget()) then return end
	Duel.NegateEffect(ev)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(re:GetHandler(),REASON_EFFECT)
	end
end
