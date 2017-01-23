--Conquest of the Supreme Ruler
function c511002734.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	c:RegisterEffect(e1)
	--trigger
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511002734.con)
	e2:SetCost(c511002734.cost)
	e2:SetOperation(c511002734.op)
	c:RegisterEffect(e2)
end
function c511002734.cfilter(c,tp)
	return c:IsType(TYPE_SYNCHRO) and c:GetPreviousControler()~=tp and c:GetReasonCard() and c:GetReasonCard():IsType(TYPE_SYNCHRO) 
		and c:GetReasonCard():IsControler(tp)
end
function c511002734.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002734.cfilter,1,nil,tp)
end
function c511002734.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511002734.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON)
	e1:SetOperation(c511002734.negop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON)
	Duel.RegisterEffect(e2,tp)
end
function c511002734.negfilter(c,tp)
	return c:GetSummonPlayer()~=tp
end
function c511002734.negop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511002734.negfilter,nil,tp)
	Duel.NegateSummon(g)
end
