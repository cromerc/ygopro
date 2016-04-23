--森の忍者バット
function c100000340.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000340,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c100000340.spcon)
	c:RegisterEffect(e1)
end
function c100000340.spcon(e,c)
	local tc=Duel.GetFieldCard(0,LOCATION_SZONE,5)
	if tc and tc:IsFaceup() then return true end
	tc=Duel.GetFieldCard(1,LOCATION_SZONE,5)
	return tc and tc:IsFaceup()
end