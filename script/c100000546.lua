--宇宙花
function c100000546.initial_effect(c)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c100000546.spcon)
	c:RegisterEffect(e2)
end
function c100000546.spfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function c100000546.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c100000546.spfilter,c:GetControler(),LOCATION_MZONE,0,2,nil)
end