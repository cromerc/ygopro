--ネオスペーシア・ロード
function c100000553.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c100000553.condition)
	e1:SetOperation(c100000553.operation)
	c:RegisterEffect(e1)
end
function c100000553.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE) and c:GetPreviousControler()==tp and c:IsCode(89943723)
end
function c100000553.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c100000553.cfilter,1,nil,tp)
end
function c100000553.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
end
