--ハーピィ・レディ－朱雀の陣－
function c100000295.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c100000295.condition)
	e1:SetOperation(c100000295.activate)
	c:RegisterEffect(e1)	
end
function c100000295.cfilter(c)
	return c:IsFaceup() and c:IsCode(76812113)
end
function c100000295.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000295.cfilter,tp,LOCATION_MZONE,0,2,nil) 
		and tp~=Duel.GetTurnPlayer()
end
function c100000295.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() then
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end
end
