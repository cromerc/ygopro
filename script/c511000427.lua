--Aid to the Doomed
function c511000427.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511000427.condition)
	e1:SetCost(c511000427.cost)
	e1:SetOperation(c511000427.activate)
	c:RegisterEffect(e1)
	--act qp in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetRange(LOCATION_HAND)
	c:RegisterEffect(e2)
end
function c511000427.cfilter(c,tp)
	return c:GetPreviousControler()==tp
end
function c511000427.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000427.cfilter,1,nil,tp)
end
function c511000427.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,2,e:GetHandler()) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,2,2,e:GetHandler())
    Duel.SendtoGrave(g,REASON_EFFECT)
end
function c511000427.activate(e,tp,eg,ep,ev,re,r,rp)
    local sk=Duel.GetTurnPlayer()
    Duel.BreakEffect()
    Duel.SkipPhase(sk,PHASE_DRAW,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(sk,PHASE_STANDBY,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(sk,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(sk,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
    Duel.SkipPhase(sk,PHASE_MAIN2,RESET_PHASE+PHASE_MAIN2,1)
    Duel.SkipPhase(sk,PHASE_END,RESET_PHASE+PHASE_END,1)
    local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetTargetRange(1,1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
