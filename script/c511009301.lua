--Willpower of Gladiator Beast
function c511009301.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511009301.actcon)
	c:RegisterEffect(e1)
	--cannot direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e2)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e5:SetTargetRange(0,LOCATION_MZONE)
	e5:SetValue(c511009301.atlimit)
	c:RegisterEffect(e5)
end
function c511009301.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x19)
end
function c511009301.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511009301.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511009301.atlimit(e,c)
	return not c:IsSetCard(0x19) or c:IsFacedown()
end