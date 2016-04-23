--限界竜シュヴァルツシルト
function c805000015.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c805000015.spcon)	
	c:RegisterEffect(e1)
end
function c805000015.filter(c)
	return c:IsFaceup() and c:GetAttack()>=2000
end
function c805000015.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c805000015.filter,c:GetControler(),0,LOCATION_MZONE,1,nil)
end