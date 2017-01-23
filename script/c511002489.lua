--幻奏のイリュージョン
function c511002489.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511002489.condition)
	e1:SetTarget(c511002489.target)
	e1:SetOperation(c511002489.activate)
	c:RegisterEffect(e1)
end
function c511002489.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>=0x08 and ph<=0x20 and tp~=ep and re:IsActiveType(TYPE_TRAP)
		and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainDisablable(ev)
end
function c511002489.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x9b)
end
function c511002489.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511002489.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002489.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511002489.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c511002489.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsControler(tp) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
	end
end
