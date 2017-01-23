--真紅眼の闇竜
function c511002021.initial_effect(c)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c511002021.val)
	c:RegisterEffect(e3)
end
function c511002021.filter(c)
	return c:IsSetCard(0x43) and c:IsType(TYPE_MONSTER)
end
function c511002021.val(e,c)
	return Duel.GetMatchingGroupCount(c511002021.filter,c:GetControler(),LOCATION_GRAVE,0,nil)*400
end
