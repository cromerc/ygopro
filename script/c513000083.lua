--DZW－魔装鵺妖衣
function c513000083.initial_effect(c)
	--Destroy 1 spell/trap
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(29095552,0))
	e0:SetCategory(CATEGORY_DESTROY)
	e0:SetType(EFFECT_TYPE_IGNITION)
	e0:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e0:SetRange(LOCATION_MZONE)
	e0:SetTarget(c513000083.destg)
	e0:SetOperation(c513000083.desop)
	c:RegisterEffect(e0)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6330307,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e1:SetTarget(c513000083.eqtg)
	e1:SetOperation(c513000083.eqop)
	c:RegisterEffect(e1)
	--destroy sub
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--Disable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e3)
	--atkup
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(70271583,1))
	e4:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_BATTLE_DAMAGE)
	e4:SetCondition(c513000083.atkcon)
	e4:SetOperation(c513000083.atkop)
	c:RegisterEffect(e4)
end
function c513000083.desfilter(c)
	return c:IsDestructable() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c513000083.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c513000083.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c513000083.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c513000083.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c513000083.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c513000083.filter(c)
	local code=c:GetCode()
	local class=_G["c"..code]
	if class==nil then return false end
	local no=class.xyz_number
	return c:IsFaceup() and c:IsSetCard(0x7f) and c:IsSetCard(0x1048) and no and no==39
end
function c513000083.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c513000083.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c513000083.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c513000083.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c513000083.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if c:IsLocation(LOCATION_MZONE) and c:IsFacedown() then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:GetControler()~=tp or tc:IsFacedown() or not tc:IsRelateToEffect(e) or not c:CheckUniqueOnField(tp) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc,true)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(c513000083.eqlimit)
	e1:SetLabelObject(tc)
	c:RegisterEffect(e1)
end
function c513000083.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c513000083.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler():GetEquipTarget()
	return ep==tp and (ec==Duel.GetAttacker() or ec==Duel.GetAttackTarget())
end
function c513000083.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	if not c:IsRelateToEffect(e) then return end
	--Atk Change
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(ec:GetAttack()*2)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	Duel.ChainAttack()
end
