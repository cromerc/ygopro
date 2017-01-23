--Comeback
function c511002918.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002918.target)
	e1:SetOperation(c511002918.activate)
	c:RegisterEffect(e1)
end
function c511002918.filter(c,tp)
	return c:IsControlerCanBeChanged() and c:IsFaceup() and c:GetOwner()==tp
end
function c511002918.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511002918.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511002918.filter,tp,0,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c511002918.filter,tp,0,LOCATION_MZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c511002918.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.GetControl(tc,tp)
	end
end
