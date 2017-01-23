--Shatiel
function c511002312.initial_effect(c)
	--atk&def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_FAIRY))
	e1:SetValue(c511002312.atkval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end
function c511002312.atkfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_FAIRY)
end
function c511002312.atkval(e,c)
	return Duel.GetMatchingGroupCount(c511002312.atkfilter,c:GetControler(),LOCATION_MZONE,0,nil)*400
end
