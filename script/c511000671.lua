--Burning Soul Sword
function c511000671.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000671.target)
	e1:SetOperation(c511000671.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000671,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetLabel(0)
	e3:SetCountLimit(1)
	e3:SetCost(c511000671.cost)
	e3:SetTarget(c511000671.atktg)
	e3:SetOperation(c511000671.atkop)
	c:RegisterEffect(e3)
end
function c511000671.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000671.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c511000671.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c511000671.cfilter(c)
	return c:GetTextAttack()>0
end
function c511000671.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local eq=e:GetHandler():GetEquipTarget()
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.CheckReleaseGroup(tp,c511000671.cfilter,1,eq)
	end
	e:SetLabel(0)
	local g=Duel.SelectReleaseGroup(tp,c511000671.cfilter,1,1,eq)
	Duel.Release(g,REASON_COST)
	local atk=g:GetFirst():GetAttack()
	if atk<0 then atk=0 end
	Duel.SetTargetParam(atk)
end
function c511000671.atkop(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler():GetEquipTarget()
	if ec then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM))
		e1:SetReset(RESET_EVENT+0x1fe0000)
		ec:RegisterEffect(e1)
	end
end
