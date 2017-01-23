--Xyz Trip
function c511001243.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001243.condition)
	e1:SetCost(c511001243.cost)
	e1:SetOperation(c511001243.activate)
	c:RegisterEffect(e1)
end
function c511001243.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local atk=Duel.GetAttacker():GetAttack()
	if chk==0 then return Duel.CheckLPCost(tp,atk) end
	Duel.PayLPCost(tp,atk)
end
function c511001243.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsType(TYPE_XYZ) and tc:IsControler(1-tp)
end
function c511001243.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
end
