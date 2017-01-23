--Rotation Blade of Pioneer
function c511002047.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511002047.target)
	e1:SetOperation(c511002047.operation)
	c:RegisterEffect(e1)
	--equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c511002047.eqlimit)
	c:RegisterEffect(e2)
	--Atk,def
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(800)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTarget(c511002047.damtg)
	e4:SetOperation(c511002047.damop)
	c:RegisterEffect(e4)
end
function c511002047.eqlimit(e,c)
	return c:IsRace(RACE_WINDBEAST) and c:IsType(TYPE_SYNCHRO)
end
function c511002047.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_WINDBEAST) and c:IsType(TYPE_SYNCHRO)
end
function c511002047.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() and c511002047.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002047.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511002047.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511002047.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c511002047.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ec=e:GetHandler():GetEquipTarget():GetMaterialCount()
	if chk==0 then return ec>0 end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ec*400)
end
function c511002047.damop(e,tp,eg,ep,ev,re,r,rp)
	local dam=e:GetHandler():GetEquipTarget():GetMaterialCount()*400
	Duel.Damage(1-tp,dam,REASON_EFFECT)
end
