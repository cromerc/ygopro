--Umbral Horror Golem
function c511001059.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(18964575,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCountLimit(1)
	e1:SetCondition(c511001059.negcon)
	e1:SetOperation(c511001059.negop)
	c:RegisterEffect(e1)
end
function c511001059.negcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos()
end
function c511001059.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
