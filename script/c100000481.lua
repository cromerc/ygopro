--天輪の葬送士
function c100000481.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c100000481.spcon)
	c:RegisterEffect(e1)
end
function c100000481.filter(c)
	return c:IsFaceup() and (c:IsSetCard(0x211) or c:IsCode(32995007)) and c:IsType(TYPE_MONSTER)
end
function c100000481.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000481.filter,tp,LOCATION_MZONE,0,1,nil)
end
