--ストライカー・トップ
function c450000111.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c450000111.ntcon)
	c:RegisterEffect(e1)
end
function c450000111.filter(c)
	return c:IsFaceup() and c:IsCode(450000110)
end
function c450000111.ntcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c450000111.filter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
