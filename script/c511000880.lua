--KC-1 Crayton
function c511000880.initial_effect(c)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c511000880.upval)
	c:RegisterEffect(e2)
end
function c511000880.upval(e,c)
	return Duel.GetMatchingGroupCount(c511000880.upfilter,c:GetControler(),LOCATION_MZONE,0,nil)*500
end
function c511000880.upfilter(c)
	return c:IsFaceup() and c:IsCode(511000882)
end
