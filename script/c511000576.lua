--Trap Sluzer
function c511000576.initial_effect(c)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c511000576.econ)
	e2:SetValue(c511000576.efilter)
	c:RegisterEffect(e2)
end
function c511000576.econ(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos()
end
function c511000576.efilter(e,te)
	return te:IsActiveType(TYPE_TRAP) and te:IsActiveType(TYPE_CONTINUOUS)
end
