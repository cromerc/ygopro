--Air Sphere
function c511002289.initial_effect(c)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(c511002289.con)
	c:RegisterEffect(e2)
end
function c511002289.filter(c)
	return c:IsFaceup() and (c:IsCode(511002289) or c:IsCode(511002290) or c:IsCode(14466224) 
		or c:IsCode(72144675) or c:IsCode(66094973) or c:IsCode(511002291) or c:IsCode(511002292))
end
function c511002289.con(e)
	return Duel.IsExistingMatchingCard(c511002289.filter,e:GetHandlerPlayer(),LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
