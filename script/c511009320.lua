--Paper Doll
function c511009320.initial_effect(c)
	--Normal monster
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_TYPE)
	e1:SetRange(LOCATION_HAND)
	e1:SetValue(TYPE_MONSTER)
	c:RegisterEffect(e1)	
end
