--Glory Level Talisman
function c511000723.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000723.target)
	e1:SetOperation(c511000723.operation)
	c:RegisterEffect(e1)
end
function c511000723.filter(c)
	return c:IsFaceup() and c:IsLevelAbove(5)
end
function c511000723.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000723.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000723.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c511000723.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000723.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsLocation(LOCATION_SZONE) then return end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
		c:CancelToGrave()
		--untargetable
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetCondition(c511000723.tgcon)
		c:RegisterEffect(e1)
		--be target
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(aux.Stringid(511000723,0))
		e2:SetCode(EVENT_BE_BATTLE_TARGET)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e2:SetRange(LOCATION_SZONE)
		e2:SetCondition(c511000723.cbcon)
		e2:SetOperation(c511000723.cbop)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
		--Equip limit
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_EQUIP_LIMIT)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetValue(c511000723.eqlimit)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e3)
	end
end
function c511000723.tgfilter(c,lv)
	return c:IsFaceup() and c:IsLevelAbove(lv+1)
end
function c511000723.tgcon(e)
	local tp=e:GetHandler():GetControler()
	local lv=e:GetHandler():GetEquipTarget():GetLevel()
	return not Duel.IsExistingMatchingCard(c511000723.tgfilter,tp,0,LOCATION_MZONE,1,nil,lv)
end
function c511000723.eqlimit(e,c)
	return c:IsLevelAbove(5)
end
function c511000723.cbcon(e,tp,eg,ep,ev,re,r,rp)
	local eq=e:GetHandler():GetEquipTarget()
	local bt=eg:GetFirst()
	local lv=eq:GetLevel()
	return eq==bt and Duel.GetAttacker():GetLevel()<lv
end
function c511000723.cbop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(Duel.GetAttacker(),REASON_EFFECT)
end
