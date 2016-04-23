--ギミック・パペット－マグネ・ドール
function c100000203.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c100000203.spcon)
	c:RegisterEffect(e1)
end
function c100000203.filter(c)
	return c:IsType(TYPE_XYZ)
end
function c100000203.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and Duel.IsExistingMatchingCard(c100000203.filter,c:GetControler(),0,LOCATION_MZONE,1,nil)
end
