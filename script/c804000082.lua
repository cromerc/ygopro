--Brotherhood of the Fire Fist - Coyote
function c804000082.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c804000082.spcon)
	c:RegisterEffect(e1)
end
function c804000082.spfilter(c)
	return c:IsSetCard(0x7c) and c:IsFaceup()
end
function c804000082.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and Duel.IsExistingMatchingCard(c804000082.spfilter,c:GetControler(),LOCATION_ONFIELD,0,1,nil)
end