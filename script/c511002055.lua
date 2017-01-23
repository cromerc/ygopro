--Starship Adjust Plane
function c511002055.initial_effect(c)
	--lv
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95100117,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetTarget(c511002055.target)
	e1:SetOperation(c511002055.operation)
	c:RegisterEffect(e1)
end
function c511002055.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c511002055.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511002055.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002055.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511002055.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c511002055.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local lv=c:GetLevel()+tc:GetLevel()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		tc:RegisterEffect(e2)
	end
end
