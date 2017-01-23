--Commande Duel 20
function c95200020.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c95200020.activate)
	c:RegisterEffect(e1)
end
function c95200020.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_TRIGGER)
	e1:SetProperty(EFFECT_FLAG_IGNORE_RANGE)
	e1:SetTargetRange(1,1)
	e1:SetTarget(c95200020.actfilter)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c95200020.actfilter(e,c)
	return c:IsAttribute(ATTRIBUTE_LIGHT+ATTRIBUTE_DARK)
end
