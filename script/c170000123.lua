--Magnet Force Minus
function c170000123.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c170000123.target)
	e1:SetOperation(c170000123.operation)
	c:RegisterEffect(e1)
end
function c170000123.filter(c)
	return c:IsFaceup()
end
function c170000123.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c170000123.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c170000123.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c170000123.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c170000123.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsLocation(LOCATION_SZONE) then return end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
	Duel.Equip(tp,c,tc)
	c:CancelToGrave()
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c170000123.eqlimit)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
    --cannot be battle target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTargetRange(0,LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e5:SetCondition(c170000123.ocon1)
	e5:SetTarget(c170000123.tg)
	e5:SetValue(1)
	tc:RegisterEffect(e5,tp)
	--Must attack a minus
    local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e3:SetCondition(c170000123.ocon2)
	e3:SetTarget(c170000123.tg2)
	e3:SetValue(c170000123.vala)
	tc:RegisterEffect(e3,tp)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_MUST_ATTACK)
	e4:SetCondition(c170000123.becon)
	tc:RegisterEffect(e4)
	end
end
function c170000123.eqlimit(e,c)
	return c:IsFaceup()
end
function c170000123.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
function c170000123.ocon1(e)
	local c=e:GetHandler()
	return Duel.GetAttacker()==c:GetEquipTarget()
end
function c170000123.tg(e,c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xAEF) or c:IsSetCard(0x5F1A62F)
end
function c170000123.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0x26F4)
end
function c170000123.ocon2(e)
	local c=e:GetHandler()
	return Duel.GetAttacker()==c:GetEquipTarget() and 
	Duel.IsExistingMatchingCard(c170000123.filter2,c:GetControler(),0,LOCATION_MZONE,1,nil) and c:IsAttackable()
end
function c170000123.tg2(e,c)
	return not (c:IsSetCard(0x26F4) and c:IsFaceup())
end
function c170000123.vala(e,c)
	return c==e:GetHandler()
end
function c170000123.befilter(c)
	return c:IsAttackable()
end
function c170000123.becon(e,c)
local c=e:GetHandler()
	return Duel.GetAttacker()==c:GetEquipTarget() and Duel.IsExistingMatchingCard(c170000123.filter,c:GetControler(),0,LOCATION_MZONE,1,nil) and c:IsAttackable()
end