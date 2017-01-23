--Elemental Storm
function c511001072.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001072.target)
	e1:SetOperation(c511001072.activate)
	c:RegisterEffect(e1)
end
function c511001072.filter(c)
	return c:GetAttackAnnouncedCount()==0 and c:IsFaceup() and c:IsSetCard(0x3008) 
		and Duel.IsExistingMatchingCard(c511001072.dfilter,c:GetControler(),0,LOCATION_MZONE,1,c,c:GetBaseAttack())
end
function c511001072.dfilter(c,atk)
	return c:IsFaceup() and c:IsDestructable() and c:GetBaseAttack()<atk
end
function c511001072.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001072.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001072.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511001072.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
end
function c511001072.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local dg=Duel.SelectMatchingCard(tp,c511001072.dfilter,tp,0,LOCATION_MZONE,1,1,nil,tc:GetBaseAttack())
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
