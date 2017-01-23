--Junk Giant
function c511000739.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511000739.spcon)
	c:RegisterEffect(e1)
end
function c511000739.filter(c)
	return c:IsFaceup() and c:GetLevel()>=5
end
function c511000739.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000739.filter,tp,0,LOCATION_MZONE,1,nil)
end
