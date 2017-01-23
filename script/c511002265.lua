--酒呑童子
function c511002265.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetCondition(c511002265.atkcon)
	e1:SetValue(2000)
	c:RegisterEffect(e1)
end
function c511002265.atkcon(e)
	local c=e:GetHandler()
	return c:GetPreviousLocation()==LOCATION_GRAVE 
		and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end