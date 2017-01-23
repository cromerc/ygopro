--Champion's Pulse
function c511002637.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002637.condition)
	e1:SetTarget(c511002637.target)
	e1:SetOperation(c511002637.activate)
	c:RegisterEffect(e1)
end
function c511002637.cfilter(c)
	return c:IsSetCard(0x21a) or c:IsCode(82382815)
end
function c511002637.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE 
		and Duel.IsExistingMatchingCard(c511002637.cfilter,tp,LOCATION_GRAVE,0,2,nil)
end
function c511002637.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,1-tp,1000)
end
function c511002637.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(1-tp,1000,REASON_EFFECT)
	Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
end
