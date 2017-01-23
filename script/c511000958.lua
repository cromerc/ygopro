--Shadow Concealing Darkness
function c511000958.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c511000958.indcon)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsDefensePos))
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--self destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c511000958.descon)
	c:RegisterEffect(e3)
end
function c511000958.indfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DARK)
end
function c511000958.indcon(e)
	return Duel.IsExistingMatchingCard(c511000958.indfilter,e:GetOwnerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c511000958.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c511000958.descon(e)
	return Duel.IsExistingMatchingCard(c511000958.filter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
