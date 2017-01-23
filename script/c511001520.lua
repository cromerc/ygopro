--Barrier Ninjitsu Art of Gathering Shadows
function c511001520.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetCondition(c511001520.actcon)
	e1:SetTarget(c511001520.cost1)
	e1:SetOperation(c511001520.operation1)
	c:RegisterEffect(e1)
	--instant(chain)
	local e2=Effect.CreateEffect(c)
	e2:SetHintTiming(0,TIMING_BATTLE_START)
	e2:SetDescription(aux.Stringid(79205581,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1)
	e2:SetCondition(c511001520.condition2)
	e2:SetTarget(c511001520.cost2)
	e2:SetOperation(c511001520.operation2)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c511001520.descon)
	e3:SetOperation(c511001520.desop)
	c:RegisterEffect(e3)
end
function c511001520.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2b)
end
function c511001520.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001520.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511001520.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE) and Duel.GetTurnPlayer()~=tp 
		and Duel.SelectYesNo(tp,aux.Stringid(61965407,0)) then
		Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
		e:SetLabel(1)
	else e:SetLabel(0) end
end
function c511001520.operation1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if e:GetLabel()==1 then
		Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end
end
function c511001520.condition2(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE) and Duel.GetTurnPlayer()~=tp 
end
function c511001520.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c511001520.operation2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
end
function c511001520.desfilter(c,tp)
	return c:IsSetCard(0x2b) and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousControler()==tp
end
function c511001520.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001520.desfilter,1,nil,tp)
end
function c511001520.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
