--Paparazzi Pest
function c511002682.initial_effect(c)
	--lv up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81759748,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511002682.cost)
	e1:SetTarget(c511002682.target)
	e1:SetOperation(c511002682.operation)
	c:RegisterEffect(e1)
end
function c511002682.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c511002682.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c511002682.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511002682.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002682.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511002682.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511002682.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(2)
		tc:RegisterEffect(e1)
	end
end
