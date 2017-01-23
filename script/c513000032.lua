--N・ブラック・パンサー
function c513000032.initial_effect(c)
	--copy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(43237273,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c513000032.target)
	e1:SetOperation(c513000032.operation)
	c:RegisterEffect(e1)
end
function c513000032.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c513000032.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) and not tc:IsType(TYPE_TOKEN) then
		local code=tc:GetOriginalCode()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		e1:SetCode(EFFECT_ADD_CODE)
		e1:SetValue(code)
		c:RegisterEffect(e1)
		if not tc:IsType(TYPE_TRAPMONSTER) then
			c:CopyEffect(code,RESET_EVENT+0x1ff0000,1)
		end
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_ATTACK_FINAL)
		e2:SetReset(RESET_EVENT+0x1ff0000)
		e2:SetValue(tc:GetAttack())
		c:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e3:SetReset(RESET_EVENT+0x1ff0000)
		e3:SetValue(tc:GetDefense())
		c:RegisterEffect(e3)
	end
end
