--Last Trick
function c511001857.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE)
	e1:SetOperation(c511001857.activate)
	c:RegisterEffect(e1)
end
function c511001857.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_ACTIVATING)
	e1:SetOperation(c511001857.regop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511001857.regop(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if rp==tp or not re:IsHasType(EFFECT_TYPE_ACTIVATE) or not re:IsActiveType(TYPE_SPELL) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetCode(EVENT_LEAVE_FIELD_P)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetOperation(c511001857.repop)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	rc:RegisterEffect(e1)
end
function c511001857.repop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetDestination()~=LOCATION_GRAVE then return end
	local p=e:GetOwner():GetOwner()
	Duel.SendtoHand(e:GetHandler(),p,REASON_EFFECT)
	Duel.ConfirmCards(1-p,e:GetHandler())
end
