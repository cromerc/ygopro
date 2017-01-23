--Lunar Eclipse
function c511001287.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001287.condition)
	e1:SetOperation(c511001287.activate)
	c:RegisterEffect(e1)
end
function c511001287.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xdf)
end
function c511001287.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001287.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511001287.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xdf))
	e1:SetValue(c511001287.efilter)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	Duel.RegisterEffect(e2,tp)
end
function c511001287.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP) and e:GetOwnerPlayer()~=te:GetOwnerPlayer()
end
