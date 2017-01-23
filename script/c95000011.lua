--Toon Summoned Skull
function c95000011.initial_effect(c)
    --no type/attribute/level
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_RACE)
	e1:SetValue(0)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	c:RegisterEffect(e2)
	c:SetStatus(STATUS_NO_LEVEL,true)
	--direct attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DIRECT_ATTACK)
	e3:SetCondition(c95000011.dircon)
	c:RegisterEffect(e3)
end
c95000011.mark=0
function c95000011.dirfilter(c)
	return c:IsFaceup() and c:IsCode(95000012)
end
function c95000011.dircon(e)
	return Duel.IsExistingMatchingCard(c95000011.dirfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
