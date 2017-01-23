--Future Energy
function c511002815.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511002815.condition)
	e1:SetTarget(c511002815.target)
	e1:SetOperation(c511002815.activate)
	c:RegisterEffect(e1)
end
function c511002815.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511002815.filter2(c)
	return c:GetAttack()>0
end
function c511002815.condition(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c511002815.filter,tp,LOCATION_MZONE,0,nil)
	local g2=Duel.GetMatchingGroup(c511002815.filter,tp,0,LOCATION_MZONE,nil)
	local gc1=g1:Filter(c511002815.filter2,nil)
	local gc2=g2:Filter(c511002815.filter2,nil)
	return g1:GetCount()>0 and g2:GetCount()>0 and gc1:GetSum(Card.GetAttack)<gc2:GetSum(Card.GetAttack)
end
function c511002815.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511002815.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(tc:GetAttack()*2)
		tc:RegisterEffect(e1)
	end
end
