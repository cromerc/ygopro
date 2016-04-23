--Glare of the Black Cat
function c51370051.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c51370051.condition)
	e1:SetOperation(c51370051.activate)
	c:RegisterEffect(e1)
end
function c51370051.cfilter(c)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()~=tp and ph==PHASE_BATTLE and c:IsFacedown()
end
function c51370051.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c51370051.cfilter,tp,LOCATION_MZONE,0,2,nil)
end
function c51370051.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
end
