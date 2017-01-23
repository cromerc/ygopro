--Trap Request
function c511000583.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)	
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000583,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)	
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511000583.condition)
	e2:SetOperation(c511000583.operation)
	c:RegisterEffect(e2)
end
function c511000583.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c511000583.filter(c)
	return c:IsType(TYPE_TRAP) and c:IsSSetable()
end
function c511000583.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(1-tp,LOCATION_SZONE)<=0 then return end
	local sg=Duel.GetMatchingGroup(c511000583.filter,tp,0,LOCATION_DECK,nil)
	Duel.ConfirmCards(tp,sg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=sg:Select(tp,1,1,nil)
	local tc=g:GetFirst()
	if g:GetCount()>0 then
		Duel.SSet(1-tp,tc)
		Duel.ConfirmCards(tp,g)
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e2:SetCode(EVENT_LEAVE_FIELD)
		e2:SetOperation(c511000583.damop)
		e2:SetReset(RESET_EVENT+0x47e0000)
		tc:RegisterEffect(e2,true)
	end
end
function c511000583.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(tp,1000,REASON_EFFECT)
end
