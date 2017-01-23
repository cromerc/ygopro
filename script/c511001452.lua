--Heraldry Catastrophe
function c511001452.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001452.target)
	e1:SetOperation(c511001452.activate)
	c:RegisterEffect(e1)
end
function c511001452.filter(c,tp)
	return c:IsFaceup() and c:GetOwner()==tp
end
function c511001452.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511001452.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511001452.filter,tp,0,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511001452.filter,tp,0,LOCATION_MZONE,1,1,nil,tp)
end
function c511001452.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_TURN_END)
		e1:SetCountLimit(1)
		e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		e1:SetOperation(c511001452.op)
		e1:SetLabelObject(tc)
		Duel.RegisterEffect(e1,tp)
		tc:CreateEffectRelation(e1)
	end
end
function c511001452.desfilter(c,atk)
	return c:IsFaceup() and c:GetAttack()<=atk and c:IsDestructable()
end
function c511001452.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local g=Duel.GetMatchingGroup(c511001452.desfilter,tp,0,LOCATION_MZONE,tc,tc:GetAttack())
	if tc:IsRelateToEffect(e) and tc:IsControler(1-tp) and g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(68535320,0)) then
		Duel.Hint(HINT_CARD,0,511001452)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=g:Select(tp,1,g:GetCount(),nil)
		Duel.HintSelection(sg)
		if Duel.Destroy(sg,REASON_EFFECT)>0 then
			Duel.BreakEffect()
			local dg=Duel.GetOperatedGroup()
			local sum=dg:GetSum(Card.GetAttack)
			Duel.Damage(1-tp,sum,REASON_EFFECT)
		end
	end
end
