--Celestial Guard
--Scripted by Snrk
function c511008012.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511008012.activate)
	c:RegisterEffect(e1)
end
function c511008012.filter(e,c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c511008012.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e1:SetTarget(c511008012.filter)
--	e1:SetValue(c511008012.indval)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
--function c511008012.indval(e,re,rp)
--function c511008012.indval(e,te)
--	return te:GetOwner()~=e:GetOwner()
--	return rp~=e:GetHandlerPlayer()
--end