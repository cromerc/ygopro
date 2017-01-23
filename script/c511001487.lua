--Tachyon Flare Wing
function c511001487.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCondition(c511001487.condition)
	e1:SetTarget(c511001487.target)
	e1:SetOperation(c511001487.activate)
	c:RegisterEffect(e1)
end
function c511001487.cfilter(c,tp)
	return c:IsType(TYPE_XYZ) and c:GetSummonPlayer()~=tp
end
function c511001487.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001487.cfilter,1,nil,tp)
end
function c511001487.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x107b)
end
function c511001487.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511001487.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001487.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c511001487.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511001487.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsLocation(LOCATION_SZONE) then return end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:GetControler()==c:GetControler() then
		Duel.Equip(tp,c,tc)
		c:CancelToGrave()
		--disable
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_SZONE)
		e1:SetTargetRange(0,LOCATION_MZONE)
		e1:SetTarget(c511001487.disable)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		--Equip limit
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_EQUIP_LIMIT)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetValue(c511001487.eqlimit)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
		--Save Monster
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_EQUIP)
		e3:SetCode(EFFECT_DESTROY_REPLACE)
		e3:SetTarget(c511001487.destg)
		e3:SetOperation(c511001487.desop)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e3)
	end
end
function c511001487.disable(e,c)
	return c:IsType(TYPE_XYZ) or bit.band(c:GetOriginalType(),TYPE_XYZ)==TYPE_XYZ
end
function c511001487.eqlimit(e,c)
	return c:GetControler()==e:GetOwnerPlayer() and c:IsSetCard(0x107b)
end
function c511001487.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tg=c:GetEquipTarget()
	if chk==0 then return c and not c:IsStatus(STATUS_DESTROY_CONFIRMED)
		and tg end
	return Duel.SelectYesNo(tp,aux.Stringid(511001487,0))
end
function c511001487.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=c:GetEquipTarget()
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
end
