--エクシーズ・エージェント
function c805000005.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTarget(c805000005.target)
	e1:SetOperation(c805000005.operation)
	c:RegisterEffect(e1)
end
function c805000005.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x7f)
end
function c805000005.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c805000005.filter(chkc) end
	if chk==0 then return Duel.GetFlagEffect(tp,805000005)==0
		and Duel.IsExistingTarget(c805000005.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c805000005.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.RegisterFlagEffect(tp,805000005,0,0,0)
end
function c805000005.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.Overlay(tc,Group.FromCards(c))
	end
end
