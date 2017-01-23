--Heroic Growth
function c511002495.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511002495.target)
	e1:SetOperation(c511002495.operation)
	c:RegisterEffect(e1)
	--Atk Change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_SET_ATTACK)
	e2:SetCondition(c511002495.condition)
	e2:SetValue(c511002495.value)
	c:RegisterEffect(e2)
	--Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(c511002495.eqlimit)
	c:RegisterEffect(e3)
end
function c511002495.eqlimit(e,c)
	return c:IsRace(RACE_WARRIOR)
end
function c511002495.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_WARRIOR)
end
function c511002495.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and c511002495.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002495.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511002495.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511002495.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c511002495.condition(e)
	return Duel.GetLP(0)~=Duel.GetLP(1)
end
function c511002495.value(e,c)
	local p=e:GetHandler():GetControler()
	if Duel.GetLP(p)<Duel.GetLP(1-p) then
		return c:GetAttack()*2
	elseif Duel.GetLP(p)>Duel.GetLP(1-p) then
		return c:GetAttack()/2
	end
end
