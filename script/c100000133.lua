--先史遺産ソル・モノリス
function c100000133.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000133,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)	
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c100000133.condition)
	e1:SetTarget(c100000133.target)
	e1:SetOperation(c100000133.operation)
	c:RegisterEffect(e1)
end
function c100000133.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE
end
function c100000133.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x70) and not c:IsType(TYPE_XYZ)
end
function c100000133.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c100000133.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000133.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c100000133.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
end
function c100000133.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(e:GetHandler():GetLevel())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
