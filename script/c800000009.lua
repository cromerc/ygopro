-- Agathion
-- scripted by: UnknownGuest
function c800000009.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetCondition(c800000009.con)
	e1:SetOperation(c800000009.op)
	c:RegisterEffect(e1)
end
function c800000009.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsDefensePos() and ep==tp
end
function c800000009.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,0)
end