--酔いどれエンジェル
function c100000322.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetValue(c100000322.efilter)
	c:RegisterEffect(e1)
end

function c100000322.efilter(e,re)
	return re:GetOwner():IsCode(100000323)
end
