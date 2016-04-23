--White Night Fort
function c511000084.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_TRIGGER)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511000084.actcon)
	e2:SetTargetRange(0xa,0xa)
	e2:SetTarget(c511000084.aclimit)
	c:RegisterEffect(e2)
end
function c511000084.actcon(e)
	return Duel.GetTurnPlayer()~=e:GetHandler():GetControler()
end
function c511000084.aclimit(e,c)
	return c:IsType(TYPE_TRAP)
end
