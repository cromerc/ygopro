--Deep Current
function c511001198.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_ATTACK_ANNOUNCE)
    e1:SetCondition(c511001198.condition)
    e1:SetOperation(c511001198.activate)
    c:RegisterEffect(e1)
end
function c511001198.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetAttackTarget()==nil
end
function c511001198.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() then
	    Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end
end
