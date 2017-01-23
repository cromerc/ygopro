--ギミック・パペット－マグネ・ドール
function c511002739.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511002739.spcon)
	c:RegisterEffect(e1)
end
function c511002739.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511002739.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
		and	Duel.IsExistingMatchingCard(c511002739.cfilter,tp,0,LOCATION_MZONE,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
