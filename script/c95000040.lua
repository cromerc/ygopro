--Timelord Token
function c95000040.initial_effect(c)
	c:SetStatus(STATUS_NO_LEVEL,true)
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EFFECT_ADD_TYPE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(TYPE_NORMAL)
	c:RegisterEffect(e2)
end
