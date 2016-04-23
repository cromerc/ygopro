--レインボー・シャーマン
function c450000153.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c450000153.spcon)
	c:RegisterEffect(e1)
end
function c450000153.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c450000153.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and	Duel.IsExistingMatchingCard(c450000153.cfilter,c:GetControler(),0,LOCATION_MZONE,1,nil)
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end