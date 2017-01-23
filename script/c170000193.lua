--Red-Eyes Black Dragon Sword
function c170000193.initial_effect(c)
    --fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,74677422,46232525,1,true,true)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c170000193.target)
	e1:SetOperation(c170000193.operation)
	c:RegisterEffect(e1)
	--Atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(1000)
	c:RegisterEffect(e2)
	--Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--Atk Boost
    local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(c170000193.value)
	c:RegisterEffect(e4)
end
function c170000193.hermos_filter(c)
	return c:IsCode(74677422)
end
function c170000193.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c170000193.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsLocation(LOCATION_SZONE) and tc:IsLocation(LOCATION_MZONE) then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c170000193.value(e,c)
	return Duel.GetMatchingGroupCount(c170000193.atkfilter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)*500
end
function c170000193.atkfilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsFaceup()
end
