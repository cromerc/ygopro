--Curry Fiend Roo
function c511001218.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c511001218.val)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c511001218.val2)
	c:RegisterEffect(e2)
end
function c511001218.filter(c)
	return c:IsSetCard(0x208)
end
function c511001218.val(e,c)
	return Duel.GetMatchingGroupCount(c511001218.filter,c:GetControler(),LOCATION_GRAVE,0,nil)*200
end
function c511001218.filter2(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c511001218.val2(e,c)
	return Duel.GetMatchingGroupCount(c511001218.filter2,c:GetControler(),LOCATION_REMOVED,LOCATION_REMOVED,nil)*300
end
