--Instant Freeze
function c511002089.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511002089.condition)
	e1:SetTarget(c511002089.target)
	e1:SetOperation(c511002089.activate)
	c:RegisterEffect(e1)
end
function c511002089.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c511002089.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_POSITION,eg,1,0,0)
	end
end
function c511002089.activate(e,tp,eg,ep,ev,re,r,rp)
	local ec=re:GetHandler()
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		ec:CancelToGrave()
		Duel.ChangePosition(ec,POS_FACEDOWN)
		Duel.RaiseEvent(ec,EVENT_SSET,e,REASON_EFFECT,tp,tp,0)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		if Duel.GetTurnPlayer()==tp and ec:IsControler(tp) then
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_OPPO_TURN,3)
		elseif Duel.GetTurnPlayer()==tp and ec:IsControler(1-tp) then
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,3)
		elseif Duel.GetTurnPlayer()~=tp and ec:IsControler(1-tp) then
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_OPPO_TURN,3)
		else
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,3)
		end
		e1:SetValue(1)
		ec:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetCountLimit(1)
		e2:SetCondition(c511002089.turncon)
		e2:SetOperation(c511002089.turnop)
		e2:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,3)
		Duel.RegisterEffect(e2,Duel.GetTurnPlayer())
	end
end
function c511002089.turncon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511002089.turnop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	ct=ct+1
	e:SetLabel(ct)
	e:GetHandler():SetTurnCounter(ct)
	if ct==3 then
		e:GetOwner():ResetFlagEffect(1082946)
	end
end
