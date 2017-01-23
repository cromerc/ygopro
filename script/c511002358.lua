--E・HERO アイスエッジ
function c511002358.initial_effect(c)
	--ind
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(c511002358.indval)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetValue(c511002358.efilter)
	c:RegisterEffect(e2)
end
function c511002358.indval(e,c)
	return c:IsLevelAbove(4)
end
function c511002358.efilter(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:GetHandler():IsLevelAbove(4)
end
