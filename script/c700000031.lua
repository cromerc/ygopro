--Scripted by Eerie Code
--Thorn Prisoner - Darli
function c700000031.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c700000031.negcon)
	e1:SetCost(c700000031.negcost)
	e1:SetOperation(c700000031.negop)
	c:RegisterEffect(e1)
end

function c700000031.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x513)
end
function c700000031.negcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.IsExistingMatchingCard(c700000031.cfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c700000031.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,400) end
	Duel.PayLPCost(tp,400)
end
function c700000031.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end