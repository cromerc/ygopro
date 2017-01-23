--Matter Leveller
function c511000219.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000219.target)
	e1:SetOperation(c511000219.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c511000219.eqlimit)
	c:RegisterEffect(e2)
	--Attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_SET_ATTACK)
	e3:SetCondition(c511000219.condtion)
	e3:SetValue(c511000219.atkval)
	c:RegisterEffect(e3)
end
function c511000219.eqlimit(e,c)
	return c:IsCode(10992251)
end
function c511000219.filter(c)
	return c:IsFaceup() and c:IsCode(10992251)
end
function c511000219.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000219.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000219.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511000219.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000219.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c511000219.condtion(e)
	local eq=e:GetHandler():GetEquipTarget()
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and Duel.GetAttacker()==eq and Duel.GetAttackTarget()~=nil 
	and Duel.GetAttackTarget():IsDefensePos()
end
function c511000219.atkval(e,c)
	return Duel.GetAttackTarget():GetDefense()+100
end