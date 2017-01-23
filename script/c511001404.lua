--D/D Baphomet
function c511001404.initial_effect(c)
	--double lv
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001404,1))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511001404.target)
	e1:SetOperation(c511001404.operation)
	c:RegisterEffect(e1)
end
function c511001404.filter(c)
	return c:IsFaceup() and c:GetLevel()>0 and c:GetLevel()<7
end
function c511001404.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511001404.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001404.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511001404.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c511001404.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(tc:GetLevel()*2)
		tc:RegisterEffect(e1)
	end
end
