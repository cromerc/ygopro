--Counter Meowsure
function c511002161.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511002161.condition)
	e1:SetTarget(c511002161.target)
	e1:SetOperation(c511002161.activate)
	c:RegisterEffect(e1)
end
function c511002161.cfilter(c,tp)
	return c:GetPreviousControler()==tp and c:IsType(TYPE_TRAP)
end
function c511002161.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002161.cfilter,1,nil,tp)
end
function c511002161.filter(c)
	return c:IsDestructable() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c511002161.afilter(c)
	return c:IsFaceup() and c:IsSetCard(0x305)
end
function c511002161.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c511002161.filter(chkc) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(c511002161.filter,tp,0,LOCATION_ONFIELD,1,nil) 
		and Duel.IsExistingMatchingCard(c511002161.afilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511002161.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511002161.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)>0 then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local g=Duel.SelectMatchingCard(tp,c511002161.afilter,tp,LOCATION_MZONE,0,1,1,nil)
		local tg=g:GetFirst()
		if tg then
			Duel.HintSelection(g)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			e1:SetValue(tg:GetAttack()*2)
			tg:RegisterEffect(e1)
		end
	end
end
