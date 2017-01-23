--Forbidden Beast Bronn
function c511000389.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511000389.con)
	e1:SetValue(c511000389.efilter)
	c:RegisterEffect(e1)
end
function c511000389.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c511000389.con(e)
	return Duel.IsPlayerAffectedByEffect(e:GetHandlerPlayer(),511000380)
end
