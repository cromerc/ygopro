--Comic Hand
function c511000628.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL+CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511000628.condition)
	e1:SetTarget(c511000628.target)
	e1:SetOperation(c511000628.operation)
	c:RegisterEffect(e1)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	e2:SetCondition(c511000628.dircon)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_ADD_TYPE)
	e3:SetValue(TYPE_TOON)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e4:SetCondition(c511000628.atcon)
	c:RegisterEffect(e4)
	--equip limit
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_EQUIP_LIMIT)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetValue(c511000628.eqlimit)
	c:RegisterEffect(e5)
	--control
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_EQUIP)
	e6:SetCode(EFFECT_SET_CONTROL)
	e6:SetValue(c511000628.ctval)
	c:RegisterEffect(e6)
	--destroy
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCode(EVENT_LEAVE_FIELD)
	e7:SetCondition(c511000628.sdescon)
	e7:SetOperation(c511000628.sdesop)
	c:RegisterEffect(e7)
end
function c511000628.cfilter(c)
	return c:IsFaceup() and c:IsCode(15259703)
end
function c511000628.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000628.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511000628.filter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged()
end
function c511000628.eqlimit(e,c)
	return e:GetHandlerPlayer()~=c:GetControler() or e:GetHandler():GetEquipTarget()==c
end
function c511000628.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511000628.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511000628.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c511000628.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000628.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Equip(tp,c,tc)
	end
end
function c511000628.atkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c511000628.dircon(e)
	return not Duel.IsExistingMatchingCard(c511000628.atkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c511000628.atcon(e)
	return Duel.IsExistingMatchingCard(c511000628.atkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c511000628.ctval(e,c)
	return e:GetHandlerPlayer()
end
function c511000628.sfilter(c)
	return c:IsReason(REASON_DESTROY) and c:IsCode(15259703) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c511000628.sdescon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000628.sfilter,1,nil)
end
function c511000628.sdesop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
