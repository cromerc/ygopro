--Rank Wall
function c511001267.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001267.condition)
	e1:SetOperation(c511001267.activate)
	c:RegisterEffect(e1)
end
function c511001267.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return tp~=Duel.GetTurnPlayer() and a:IsType(TYPE_XYZ) and d and d:IsType(TYPE_XYZ)
		and d:GetRank()>a:GetRank()
end
function c511001267.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() then
	    Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end
end
