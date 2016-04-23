--コミックハンド
function c5698.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL+CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c5698.target)
	e1:SetOperation(c5698.operation)
	c:RegisterEffect(e1)
	--equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c5698.eqlimit)
	c:RegisterEffect(e2)
	--control
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_SET_CONTROL)
	e3:SetValue(c5698.ctval)
	c:RegisterEffect(e3)
	--add type
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_ADD_TYPE)
	e4:SetValue(TYPE_TOON)
	c:RegisterEffect(e4)
	--direct attack
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_DIRECT_ATTACK)
	e5:SetCondition(c5698.dircon)
	c:RegisterEffect(e5)
	--self destroy
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetCode(EFFECT_SELF_DESTROY)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCondition(c5698.descon)
	c:RegisterEffect(e6)
end
function c5698.cfilter(c)
	return c:IsFaceup() and c:IsCode(15259703)
end
function c5698.filter(c,tp)
	return Duel.IsExistingMatchingCard(c5698.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
		and c:IsFaceup() and c:IsControlerCanBeChanged()
end
function c5698.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c5698.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c5698.filter,tp,0,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c5698.filter,tp,0,LOCATION_MZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c5698.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c5698.descon(e) then Duel.Destroy(c,REASON_EFFECT) end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Equip(tp,c,tc)
	end
end
function c5698.eqlimit(e,c)
	return (Duel.IsExistingMatchingCard(c5698.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
		and e:GetHandlerPlayer()~=c:GetControler())
		or e:GetHandler():GetEquipTarget()==c
end
function c5698.ctval(e,c)
	return e:GetHandlerPlayer()
end
function c5698.dirfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c5698.dircon(e)
	return not Duel.IsExistingMatchingCard(c5698.dirfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c5698.descon(e)
	return not Duel.IsExistingMatchingCard(c5698.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
