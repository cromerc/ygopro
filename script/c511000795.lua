--Hell Needle Caterpillar
function c511000795.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511000795.spcon)
	c:RegisterEffect(e1)
end
function c511000795.spfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_INSECT)
end
function c511000795.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000795.spfilter,tp,LOCATION_MZONE,0,2,nil)
end
