--Corn Parade
function c511002672.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--negate attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(22991179,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c511002672.con)
	e2:SetOperation(c511002672.op)
	c:RegisterEffect(e2)
end
function c511002672.con(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsFaceup() and d:IsRace(RACE_PLANT)
end
function c511002672.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
