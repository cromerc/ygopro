--White Night Fort
function c511000084.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot trigger
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,1)
	e2:SetValue(c511000084.aclimit)
	c:RegisterEffect(e2)
end
function c511000084.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_TRAP) and Duel.GetTurnPlayer()~=re:GetHandler():GetControler()
end
