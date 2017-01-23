--Air Barrier
function c511002296.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_MAIN_END)
	e1:SetCondition(c511002296.condition)
	e1:SetOperation(c511002296.activate)
	c:RegisterEffect(e1)
end
function c511002296.cfilter(c)
	return c:IsFaceup() and (c:IsCode(511002289) or c:IsCode(511002290) or c:IsCode(14466224) or c:IsCode(72144675) 
		or c:IsCode(66094973) or c:IsCode(511002291) or c:IsCode(511002292))
end
function c511002296.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511002296.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511002296.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(0,LOCATION_MZONE)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetValue(1)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
