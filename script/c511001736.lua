--Frozen Ice Cave
function c511001736.initial_effect(c)
	--lv change
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001736.target)
	e1:SetOperation(c511001736.operation)
	c:RegisterEffect(e1)
end
function c511001736.filter(c)
	return c:IsPosition(POS_FACEUP_DEFENSE) and c:GetLevel()>0
end
function c511001736.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001736.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001736.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUPDEFENSE)
	Duel.SelectTarget(tp,c511001736.filter,tp,LOCATION_MZONE,0,1,1,nil)
 end
function c511001736.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end

