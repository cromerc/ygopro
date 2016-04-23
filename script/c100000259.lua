--先史遺産カブレラの投石機
function c100000259.initial_effect(c)
	--atk change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000259,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c100000259.condition)
	e1:SetTarget(c100000259.target)
	e1:SetOperation(c100000259.operation)
	c:RegisterEffect(e1)
end
function c100000259.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos() and Duel.CheckReleaseGroup(tp,nil,1,nil)
end
function c100000259.filter(c)
	return c:IsFaceup() and c:GetAttack()>0
end
function c100000259.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c100000259.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000259.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c100000259.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c100000259.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local g=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
		Duel.Release(g,REASON_EFFECT)
		local c=e:GetHandler()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		if c:IsRelateToEffect(e) and c:IsPosition(POS_FACEUP_ATTACK) then
			Duel.BreakEffect()
			Duel.ChangePosition(c,POS_FACEUP_DEFENCE)
		end
	end
end
