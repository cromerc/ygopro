--Moonlight Blue Cat
function c511001286.initial_effect(c)
	--double atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001286,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c511001286.target)
	e1:SetOperation(c511001286.operation)
	c:RegisterEffect(e1)
end
function c511001286.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xdf)
end
function c511001286.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511001286.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001286.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511001286.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001286.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(tc:GetAttack()*2)
		tc:RegisterEffect(e1)
	end
end
