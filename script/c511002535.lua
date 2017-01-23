--Superior Protector
function c511002535.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511002535.target)
	e1:SetOperation(c511002535.operation)
	c:RegisterEffect(e1)
end
function c511002535.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) 
		and Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511002535.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsLocation(LOCATION_SZONE) then return end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
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
		--Prevent Damage
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		e2:SetRange(LOCATION_SZONE)
		e2:SetTargetRange(LOCATION_MZONE,0)
		e2:SetValue(1)
		e2:SetTarget(c511002535.dmtg)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
		--Save Monster
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_EQUIP)
		e3:SetCode(EFFECT_DESTROY_REPLACE)
		e3:SetTarget(c511002535.destg)
		e3:SetOperation(c511002535.desop)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e3)
		--pierce
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e4:SetCode(EVENT_BATTLE_CONFIRM)
		e4:SetOperation(c511002535.prop)
		e4:SetRange(LOCATION_SZONE)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e4)
	end
end
function c511002535.dmtg(e,c)
	local ec=e:GetHandler():GetEquipTarget()
	return ec and c~=ec
end
function c511002535.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tg=c:GetEquipTarget()
	if chk==0 then return c and not c:IsStatus(STATUS_DESTROY_CONFIRMED)
		and tg and tg:IsReason(REASON_BATTLE) end
	if Duel.SelectYesNo(tp,aux.Stringid(511000778,0)) then
		c:SetStatus(STATUS_DESTROY_CONFIRMED,true)
		return true
	else return false end
end
function c511002535.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:SetStatus(STATUS_DESTROY_CONFIRMED,false)
	Duel.Destroy(c,REASON_EFFECT+REASON_REPLACE)
end
function c511002535.prop(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler():GetEquipTarget()
	local at=Duel.GetAttackTarget()
	local tc=Duel.GetAttacker()
	if tc:IsControler(1-tp) and at and ec and at==ec and ec:IsDefensePos() and tc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_PIERCE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
	end
end
