--Amorphous Barrier
function c511000452.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511000452.condition)
	e1:SetOperation(c511000452.activate)
	c:RegisterEffect(e1)
end
function c511000452.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.IsExistingMatchingCard(nil,tp,LOCATION_MZONE,0,3,nil)
end
function c511000452.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
end
