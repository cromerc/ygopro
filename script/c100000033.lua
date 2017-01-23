--ダーク・サイコ・アイ
function c100000033.initial_effect(c)
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetTarget(c100000033.target)
	e1:SetOperation(c100000033.operation)
	c:RegisterEffect(e1)
end
function c100000033.filter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged()
end
function c100000033.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c100000033.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000033.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c100000033.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c100000033.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
