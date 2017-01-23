--Altar of Mist
function c511000217.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000217.target)
	e1:SetOperation(c511000217.activate)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c511000217.filter(c)
	return c:IsType(TYPE_RITUAL) and c:IsAbleToHand()
end
function c511000217.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000217.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c511000217.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		c:CancelToGrave()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetRange(LOCATION_SZONE)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetCountLimit(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,3)
		e1:SetOperation(c511000217.tohand)
		e1:SetLabel(0)
		c:RegisterEffect(e1)
	end
end
function c511000217.tohand(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=tp then return end
	local ct=e:GetLabel()
	e:GetHandler():SetTurnCounter(ct+1)
	if ct==2 then
		if Duel.SendtoGrave(e:GetHandler(),REASON_RULE)>0 then
			if Duel.IsExistingMatchingCard(c511000217.filter,tp,LOCATION_DECK,0,1,nil) then
				local g=Duel.SelectMatchingCard(tp,c511000217.filter,tp,LOCATION_DECK,0,1,1,nil)
				if g:GetCount()>0 then
					Duel.SendtoHand(g,nil,REASON_EFFECT)
					Duel.ConfirmCards(1-tp,g)
				else
					local dg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
					Duel.ConfirmCards(1-tp,dg)
					Duel.ShuffleDeck(tp)
				end
			end
		end
	else e:SetLabel(ct+1) end
end
