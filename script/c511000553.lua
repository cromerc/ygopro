--Seraphim Blaster
function c511000553.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c511000553.val)
	c:RegisterEffect(e1)
end
function c511000553.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_FAIRY)
end
function c511000553.val(e,c)
	return Duel.GetMatchingGroupCount(c511000553.filter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)*300
end
