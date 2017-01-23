--Moonlight Purple Butterfly
function c511001290.initial_effect(c)
	--gain atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001290,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511001290.cost)
	e1:SetTarget(c511001290.tg)
	e1:SetOperation(c511001290.op)
	c:RegisterEffect(e1)
end
function c511001290.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c511001290.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION)
end
function c511001290.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511001290.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001290.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511001290.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001290.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(1000)
		tc:RegisterEffect(e1)
	end
end
