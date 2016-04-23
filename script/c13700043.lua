--Dragunity Spear of Destiny
function c13700043.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c13700043.target)
	e1:SetOperation(c13700043.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(c13700043.eqlimit)
	c:RegisterEffect(e3)
	--atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c13700043.atkup)
	c:RegisterEffect(e3)
	--~ Immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c13700043.efilter)
	c:RegisterEffect(e1)
	--Equip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,13700043)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTarget(c13700043.eqtarget)
	e1:SetOperation(c13700043.eqactivate)
	c:RegisterEffect(e1)
end
	--Equip limit
function c13700043.eqlimit(e,c)
	return c:IsSetCard(0x29)
end
	--Activate
function c13700043.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x29)
end
function c13700043.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and c1644289.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13700043.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c13700043.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c13700043.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
	--atk up
function c13700043.atkup(e,c)
	return c:GetLevel()*100
end
	--~ Immune
function c13700043.efilter(e,te)
	return te:IsActiveType(TYPE_TRAP)
end
	--Equip
function c13700043.eqfilter(c)
	return c:IsSetCard(0x29) and c:IsRace(RACE_DRAGON) and c:IsType(TYPE_TUNER)
end
function c13700043.eqtarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and
	Duel.IsExistingMatchingCard(c13700043.eqfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13700043.eqactivate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local eqc=e:GetHandler():GetEquipTarget()
	local g=Duel.SelectMatchingCard(tp,c13700043.eqfilter,tp,LOCATION_DECK,0,1,1,nil)
	local d=g:GetFirst()
		Duel.Equip(tp,d,eqc)
		--Add Equip limit
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c13700043.eqlimit2)
		e1:SetLabelObject(eqc)
		d:RegisterEffect(e1)
end
function c13700043.eqlimit2(e,c)
	return c==e:GetLabelObject()
end
