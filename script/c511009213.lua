--Grand Naval Battle
--Scripted by eclair11
function c511009213.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--double damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetCondition(c511009213.condition)
	e2:SetOperation(c511009213.operation)
	c:RegisterEffect(e2)
end
function c511009213.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(tp) and Duel.GetAttacker():IsAttribute(ATTRIBUTE_WATER)
end
function c511009213.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(1-tp,ev*2)
end