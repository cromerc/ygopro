--Amorphous Barrier
function c511001526.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001526.condition)
	e1:SetOperation(c511001526.activate)
	c:RegisterEffect(e1)
end
function c511001526.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>=3
end
function c511001526.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
end
