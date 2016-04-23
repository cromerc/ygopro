--Butterspy Protection
function c800000060.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1c0)
	e1:SetTarget(c800000060.target)
	e1:SetOperation(c800000060.operation)
	c:RegisterEffect(e1)
end
c800000060[0]=0
c800000060[1]=0
function c800000060.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAttackPos,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACK)
	local g=Duel.SelectTarget(tp,Card.IsAttackPos,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c800000060.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsAttackPos() and tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENCE)
		if tc:IsPosition(POS_FACEUP_DEFENCE) then
			c800000060[tp]=1
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_CHANGE_DAMAGE)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e1:SetTargetRange(1,0)
			e1:SetValue(c800000060.val)
			e1:SetReset(RESET_PHASE+PHASE_END,1)
			Duel.RegisterEffect(e1,tp)
		end
	end
end
function c800000060.val(e,re,dam,r,rp,rc)
	if c800000060[e:GetOwnerPlayer()]==1 or bit.band(r,REASON_EFFECT)~=0 then
		return dam/2
	else return dam end
end
