--Cookmate Potatopard
function c511001079.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_SPSUM_PARAM+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTargetRange(POS_FACEUP_ATTACK,0)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511001079.spcon)
	c:RegisterEffect(e1)
end
function c511001079.spfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x205)
end
function c511001079.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511001079.spfilter,tp,LOCATION_MZONE,0,2,nil)
end
