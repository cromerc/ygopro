--Eye of Ujat
function c511000400.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511000400.condition)
	e1:SetTarget(c511000400.target)
	e1:SetOperation(c511000400.operation)
	c:RegisterEffect(e1)
end
function c511000400.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>=2
end
function c511000400.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,1,Duel.GetAttacker())
end
function c511000400.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		--Duel.ChangeAttackTarget(tc)
		Duel.CalculateDamage(Duel.GetAttacker(),tc)
	end
end
