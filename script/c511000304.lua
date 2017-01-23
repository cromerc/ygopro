--Photon Wing
function c511000304.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000304.target)
	e1:SetOperation(c511000304.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c511000304.eqlimit)
	c:RegisterEffect(e2)
	--gain and direct
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000304,0))
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c511000304.atkcost)
	e3:SetTarget(c511000304.atktg)
	e3:SetOperation(c511000304.atkop)
	c:RegisterEffect(e3)
end
function c511000304.eqlimit(e,c)
	return c:IsSetCard(0x55)
end
function c511000304.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x55)
end
function c511000304.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and c511000304.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000304.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511000304.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000304.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function c511000304.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c511000304.atkfilter(c,cst)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and (not cst or c:GetOverlayCount()~=0)
end
function c511000304.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local chkcost=e:GetLabel()==1 and true or false
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000304.atkfilter(chkc,chkcost) end
	if chk==0 then
		e:SetLabel(0)
		return Duel.IsExistingTarget(c511000304.atkfilter,tp,LOCATION_MZONE,0,1,nil,chkcost)
	end
	e:SetLabel(0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local tc=Duel.SelectTarget(tp,c511000304.atkfilter,tp,LOCATION_MZONE,0,1,1,nil,chkcost):GetFirst()
	if chkcost then
		tc:RemoveOverlayCard(tp,tc:GetOverlayCount(),tc:GetOverlayCount(),REASON_COST)
	end
end
function c511000304.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local eq=e:GetHandler():GetEquipTarget()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(tc:GetRank()*200)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		eq:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DIRECT_ATTACK)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		eq:RegisterEffect(e2)
	end
end
