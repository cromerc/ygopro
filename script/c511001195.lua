--アンブラル・リフレッシュ
function c511001195.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER+CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001195.target)
	e1:SetOperation(c511001195.operation)
	c:RegisterEffect(e1)
end
function c511001195.filter(c)
	return c:IsFaceup() and c:GetAttack()~=c:GetBaseAttack()
end
function c511001195.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511001195.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001195.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511001195.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,0)
end
function c511001195.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local atk=tc:GetAttack()
		local batk=tc:GetBaseAttack()
		if batk==atk then return end
		local dif=(batk>atk) and (batk-atk) or (atk-batk)
		local cue=Duel.Recover(tp,dif,REASON_EFFECT)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(tc:GetBaseAttack())
		tc:RegisterEffect(e1)
	end
end
