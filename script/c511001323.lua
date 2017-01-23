--Great Kite of Ninja
function c511001323.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511001323.target)
	e1:SetOperation(c511001323.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c511001323.eqlimit)
	c:RegisterEffect(e2)
	--Indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetValue(c511001323.indval)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e5:SetValue(aux.imval1)
	c:RegisterEffect(e5)
	--no target attack
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_DIRECT_ATTACK)
	e6:SetRange(LOCATION_SZONE)
	e6:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e6:SetTarget(c511001323.dirtg)
	c:RegisterEffect(e6)
	--Direct attack
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCountLimit(1)
	e7:SetCost(c511001323.dacost)
	e7:SetOperation(c511001323.daop)
	c:RegisterEffect(e7)
end
function c511001323.eqlimit(e,c)
	return c:IsCode(511001322)
end
function c511001323.filter(c)
	return c:IsFaceup() and c:IsCode(511001322)
end
function c511001323.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511001323.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001323.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511001323.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511001323.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c511001323.indval(e,re,rp)
	return re:IsActiveType(TYPE_SPELL)
end
function c511001323.dirfilter(c,e)
	return c~=e:GetHandler():GetEquipTarget()
end
function c511001323.dirtg(e,c)
	return not Duel.IsExistingMatchingCard(c511001323.dirfilter,c:GetControler(),0,LOCATION_MZONE,1,nil,e)
end
function c511001323.dacost(e,tp,eg,ep,ev,re,r,rp,chk)
	local eq=e:GetHandler():GetEquipTarget()
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,eq) end
	local g=Duel.SelectReleaseGroup(tp,nil,1,1,eq)
	Duel.Release(g,REASON_COST)
end
function c511001323.daop(e,tp,eg,ep,ev,re,r,rp)
	local eq=e:GetHandler():GetEquipTarget()
	local c=e:GetHandler()
	if eq:IsFaceup() and c:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		eq:RegisterEffect(e1)
	end
end
