--ワルキューレ・ドリッド
function c100000534.initial_effect(c)
	--atk def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c100000534.value)
	c:RegisterEffect(e2)
end
function c100000534.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c100000534.value(e,c)
	return Duel.GetMatchingGroupCount(c100000534.filter,c:GetControler(),LOCATION_REMOVED,LOCATION_REMOVED,nil)*100
end
