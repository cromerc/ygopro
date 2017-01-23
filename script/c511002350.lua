--E・HERO オーシャン
function c511002350.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c511002350.dircon)
	c:RegisterEffect(e1)
end
function c511002350.filter(c)
	return c:IsFaceup() and c:IsCode(22702055)
end
function c511002350.dircon(e)
	return Duel.IsExistingMatchingCard(c511002350.filter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.IsEnvironment(22702055)
end
