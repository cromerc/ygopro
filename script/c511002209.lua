--Those We Protect
function c511002209.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(59560625,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetTarget(c511002209.target)
	e1:SetOperation(c511002209.activate)
	c:RegisterEffect(e1)
end
function c511002209.filter(c,a)
	return c~=a
end
function c511002209.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(c511002209.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,d,a) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511002209.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,d,a)
end
function c511002209.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.ChangeAttackTarget(tc)
	end
end
