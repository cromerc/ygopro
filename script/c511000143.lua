--Red Ghost Moon
function c511000143.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START+TIMING_BATTLE_END)
	e1:SetCondition(c511000143.condition)
	e1:SetCost(c511000143.cost)
	e1:SetTarget(c511000143.target)
	e1:SetOperation(c511000143.activate)
	c:RegisterEffect(e1)
end
function c511000143.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
end
function c511000143.cfilter(c)
	return c:IsRace(RACE_ZOMBIE) and c:IsDiscardable()
end
function c511000143.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000143.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c511000143.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c511000143.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsPosition,tp,0,LOCATION_MZONE,1,nil,POS_FACEUP_ATTACK) end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,0)
end
function c511000143.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPPO)
	local g=Duel.SelectMatchingCard(tp,Card.IsPosition,tp,0,LOCATION_MZONE,1,1,nil,POS_FACEUP_ATTACK)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		Duel.Recover(tp,tc:GetAttack(),REASON_EFFECT)
		Duel.BreakEffect()
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end
end
