--Explosion Wing
function c511000724.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511000724.operation)
	c:RegisterEffect(e1)
end
function c511000724.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetOperation(c511000724.damop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511000724.cfilter(c)
	return c:IsReason(REASON_DESTROY) and c:IsReason(REASON_EFFECT) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c511000724.damop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c511000724.cfilter,1,nil) then
		Duel.Damage(1-tp,eg:GetCount()*500,REASON_EFFECT)
	end
end
