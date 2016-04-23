--ケンタウルミナ
function c500000143.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,500000141,500000142,true,true)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(500000143,0))
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c500000143.discon)
	e1:SetTarget(c500000143.target)
	e1:SetOperation(c500000143.activate)
	c:RegisterEffect(e1)
end
function c500000143.discon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
	and rp~=tp and tp==Duel.GetTurnPlayer()
end
function c500000143.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if not re:GetHandler():IsStatus(STATUS_ACT_FROM_HAND) then
			return re:GetHandler():IsCanTurnSet()
		else return true end
	end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) and re:GetHandler():IsStatus(STATUS_ACT_FROM_HAND) then
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,eg,1,0,0)
	end
end
function c500000143.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	local rc=re:GetHandler()
	if rc:IsRelateToEffect(re) then
		if rc:IsStatus(STATUS_ACT_FROM_HAND) then
			rc:CancelToGrave()
			Duel.SendtoHand(rc,nil,REASON_EFFECT)
		else
			if rc:IsCanTurnSet() then
				rc:CancelToGrave()
				Duel.ChangePosition(rc,POS_FACEDOWN)
				--rc:SetStatus(STATUS_SET_TURN,false)
				Duel.RaiseEvent(rc,EVENT_SSET,e,REASON_EFFECT,tp,tp,0)
			end
		end
	end
end