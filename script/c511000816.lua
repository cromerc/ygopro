--The Magician's Wisdom
function c511000816.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)	
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511000816.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c511000816.handcon)
	c:RegisterEffect(e2)
end
function c511000816.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetCondition(c511000816.damcon)
	e1:SetOperation(c511000816.damop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511000816.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsPreviousLocation,1,nil,LOCATION_ONFIELD)
end
function c511000816.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(Card.IsPreviousLocation,nil,LOCATION_ONFIELD)
	Duel.Damage(1-tp,ct*300,REASON_EFFECT)
end
function c511000816.handcon(e)
	return Duel.GetTurnPlayer()==e:GetHandler():GetControler()
end
