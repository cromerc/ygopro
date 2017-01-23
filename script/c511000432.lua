--Pumpkin Carriage
function c511000432.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c511000432.datg)
	c:RegisterEffect(e1)
end
function c511000432.datg(e,c)
	return c:IsCode(511000431)
end
