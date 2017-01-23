--Dragonroid
function c511001190.initial_effect(c)
	--Type Machine
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CHANGE_RACE)
	e2:SetCondition(c511001190.con)
	e2:SetValue(RACE_DRAGON)
	c:RegisterEffect(e2)
end
function c511001190.con(e)
	return e:GetHandler():IsLocation(LOCATION_GRAVE)
end
