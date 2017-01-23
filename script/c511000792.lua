--Void Shield
function c511000792.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000792,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(2)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCondition(c511000792.condition)
	e2:SetOperation(c511000792.activate)
	c:RegisterEffect(e2)
end
function c511000792.condition(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_CHAINING) and Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_HAND,0)==0
end
function c511000792.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
