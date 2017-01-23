--Negate Attack (anime)
--scripted by andré
function c511004341.initial_effect(c)
	--negate atack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511004341.condition)
	e1:SetOperation(c511004341.operation)
	c:RegisterEffect(e1)
end
function c511004341.condition(e,tp,ev,eg,ep,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511004341.operation(e,tp,ev,eg,ep,re,r,rp)
	if Duel.NegateAttack() then
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end
end