--Medallion of Gladiator Beast
function c511009302.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x19))
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--damage reduce
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20281581,0))
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetCondition(c511009302.rdcon)
	e2:SetOperation(c511009302.rdop)
	c:RegisterEffect(e2)
end
function c511009302.rdcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c511009302.rdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,ev*2)
end