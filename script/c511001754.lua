--Arbitrator
function c511001754.initial_effect(c)
	--end bp
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001754,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c511001754.condition)
	e1:SetCost(c511001754.cost)
	e1:SetOperation(c511001754.operation)
	c:RegisterEffect(e1)
end
function c511001754.cfilter(c,tp)
	return c:GetPreviousControler()==tp
end
function c511001754.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>=0x08 and ph<=0x20 and eg:IsExists(c511001754.cfilter,1,nil,tp)
end
function c511001754.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c511001754.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
end
