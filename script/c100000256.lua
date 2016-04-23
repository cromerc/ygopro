--ダイダラボッチ
function c100000256.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c100000256.val)
	c:RegisterEffect(e2)
end
function c100000256.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_ZOMBIE)
end
function c100000256.val(e,c)
	return Duel.GetMatchingGroupCount(c100000256.filter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)*200
end
