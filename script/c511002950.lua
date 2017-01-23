--Inland
function c511002950.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002950.condition)
	c:RegisterEffect(e1)
	--Atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetTarget(c511002950.tg)
	e2:SetValue(22702055)
	c:RegisterEffect(e2)
	--level
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_LEVEL)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,LOCATION_HAND+LOCATION_MZONE)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_WATER))
	e3:SetValue(-1)
	c:RegisterEffect(e3)
end
function c511002950.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	local tc2=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
	return (tc1 and tc1:IsFaceup()) or (tc2 and tc2:IsFaceup())
end
function c511002950.tg(e,c)
	return c:GetSequence()==5
end
