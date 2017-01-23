--時械巫女
function c513000048.initial_effect(c)
	c:EnableUnsummonable()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c513000048.spcon)
	c:RegisterEffect(e1)
	--double tribute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e2:SetValue(c513000048.condition)
	c:RegisterEffect(e2)
end
function c513000048.condition(e,c)
	return c:IsRace(RACE_FAIRY)
end
function c513000048.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
