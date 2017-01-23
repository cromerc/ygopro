--Coded by Lyris
--fixed by MLD
--Devoted Love
function c511007027.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START+TIMING_DAMAGE_STEP)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c511007027.condition)
	e1:SetTarget(c511007027.target)
	e1:SetOperation(c511007027.operation)
	c:RegisterEffect(e1)
end
function c511007027.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>=0x08 and ph<=0x20 and Duel.GetTurnPlayer()~=tp
end
function c511007027.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
end
function c511007027.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	Duel.BreakEffect()
	Duel.Draw(1-tp,1,REASON_EFFECT)
	--At the End Phase of this turn, your Life Points become 0. [Power Bond & Self-Destruct Button]
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetOperation(c511007027.damop)
	Duel.RegisterEffect(e2,tp)
end
function c511007027.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511007027)
	Duel.SetLP(tp,0)
end
