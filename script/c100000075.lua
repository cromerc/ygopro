--レッド・ノヴァ
function c100000075.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c100000075.spcon)
	c:RegisterEffect(e1)
end
function c100000075.filter(c)
	return c:IsFaceup() and c:GetCode()==70902743
end
function c100000075.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c100000075.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
