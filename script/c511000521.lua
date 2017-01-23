--Rose Papillon
function c511000521.initial_effect(c)
	--direct attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DIRECT_ATTACK)
	e4:SetCondition(c511000521.dircon)
	c:RegisterEffect(e4)
end
function c511000521.atkfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_INSECT)
end
function c511000521.dircon(e)
	return Duel.IsExistingMatchingCard(c511000521.atkfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
