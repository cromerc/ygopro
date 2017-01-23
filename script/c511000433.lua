--Glass Slippers
function c511000433.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000433.target)
	e1:SetOperation(c511000433.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c511000433.eqlimit)
	c:RegisterEffect(e2)
	--change equip
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000433,0))
	e3:SetCategory(CATEGORY_EQUIP)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511000433.eqcon)
	e3:SetTarget(c511000433.eqtg)
	e3:SetOperation(c511000433.eqop)
	c:RegisterEffect(e3)
	--Atk up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(-1000)
	e4:SetCondition(c511000433.atkcon)
	c:RegisterEffect(e4)
	--at limit
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e5:SetCondition(c511000433.atkcon)
	e5:SetTarget(c511000433.atlimit)
	e5:SetValue(c511000433.atkval)
	c:RegisterEffect(e5)
	--reequip to Cinderella
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(511000433,2))
	e6:SetCategory(CATEGORY_EQUIP)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e6:SetCode(EVENT_TO_GRAVE)
	e6:SetCondition(c511000433.eqcon2)
	e6:SetTarget(c511000433.eqtg2)
	e6:SetOperation(c511000433.eqop)
	c:RegisterEffect(e6)
end
function c511000433.eqlimit(e,c)
	return c:IsCode(511000431) or c:GetControler()~=e:GetHandler():GetControler()
end
function c511000433.filter(c,e)
	return c:IsFaceup() and (c:IsCode(511000431) or c:GetControler()~=e:GetHandler():GetControler())
end
function c511000433.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000433.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000433.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511000433.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000433.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c511000433.eqcon(e,tp,eg,ep,ev,re,r,rp)
	local eq=e:GetHandler():GetEquipTarget()
	return ep~=tp and eq:IsCode(511000431) and eg:GetFirst()==eq
end
function c511000433.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local eq=e:GetHandler():GetEquipTarget()
	return eq:GetControler()~=e:GetHandler():GetControler()
end
function c511000433.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,0,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511000433,1))
	local tc=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511000433.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Equip(tp,c,tc)
	else
		Duel.SendtoGrave(c,REASON_EFFECT) 
	end
end
function c511000433.atlimit(e,c)
	return c:IsCode(511000431)
end
function c511000433.atkval(e,c)
	return c==e:GetHandler():GetEquipTarget()
end
function c511000433.eqcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_LOST_TARGET) and e:GetHandler():GetPreviousEquipTarget():IsReason(REASON_DESTROY)
end
function c511000433.eqtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c511000433.filter,tp,LOCATION_MZONE,0,1,nil,e) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511000433,1))
	local tc=Duel.SelectTarget(tp,c511000433.filter,tp,LOCATION_MZONE,0,1,1,nil,e)
end
