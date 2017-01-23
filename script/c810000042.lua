-- Amplifier (Anime)
-- scripted by: UnknownGuest
function c810000042.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetTarget(c810000042.target)
	e1:SetOperation(c810000042.operation)
	c:RegisterEffect(e1)
	-- Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c810000042.eqlimit)
	c:RegisterEffect(e2)
	-- immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e3:SetTarget(c810000042.etarget)
	e3:SetValue(c810000042.efilter)
	c:RegisterEffect(e3)
	-- leave
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetOperation(c810000042.desop)
	c:RegisterEffect(e4)
	-- cannot disable
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_DISABLE)
	c:RegisterEffect(e5)
	-- Atk up 500
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_EQUIP)
	e6:SetCode(EFFECT_UPDATE_ATTACK)
	e6:SetValue(500)
	c:RegisterEffect(e6)
	-- atk up 300
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c810000042.atkcon)
	e4:SetOperation(c810000042.atkop)
	c:RegisterEffect(e4)
end
function c810000042.eqlimit(e,c)
	return c:IsCode(77585513)
end
function c810000042.filter(c)
	return c:IsFaceup() and c:IsCode(77585513)
end
function c810000042.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c810000042.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c810000042.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c810000042.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c810000042.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c810000042.etarget(e,c)
	local ec=e:GetHandler():GetEquipTarget()
	return c:IsType(TYPE_TRAP) and ec and c:GetControler()==ec:GetControler()
end
function c810000042.efilter(e,re)
	return re:GetHandler()==e:GetHandler():GetEquipTarget()
end
function c810000042.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c810000042.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c810000042.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(810000042)==0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(300)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		c:RegisterFlagEffect(810000042,RESET_EVENT+0x1fe0000,0,0)
		e:SetLabelObject(e1)
		e:SetLabel(2)
	else
		local pe=e:GetLabelObject()
		local ct=e:GetLabel()
		e:SetLabel(ct+1)
		pe:SetValue(ct*300)
	end
end
