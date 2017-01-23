--Ancestor Bird
function c511002897.initial_effect(c)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_INDESTRUCTABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(1)
	e1:SetCondition(c511002897.condition)
	c:RegisterEffect(e1)
end
function c511002897.filter(c,tp)
	return c:IsType(TYPE_MONSTER) and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,2,c,c:GetCode())
end
function c511002897.condition(e)
	return Duel.IsExistingMatchingCard(c511002897.filter,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil,e:GetHandlerPlayer())
end
