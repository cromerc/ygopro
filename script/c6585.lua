--Scripted by Eerie Code
--Scheduled Extinction
function c6585.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetHintTiming(0,TIMING_MAIN_END)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c6585.condition)
	e1:SetCost(c6585.cost)
	e1:SetOperation(c6585.activate)
	c:RegisterEffect(e1)
end

function c6585.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c6585.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000)
	else Duel.PayLPCost(tp,2000) end
end
function c6585.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)  
	e1:SetCountLimit(1)
	e1:SetLabel(0)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,4)
	e1:SetTarget(c6585.tgtg)
	e1:SetOperation(c6585.tgop)
	Duel.RegisterEffect(e1,tp)
end
function c6585.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetFieldGroup(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
end
function c6585.tgop(e,tp,eg,ep,ev,re,r,rp)
	if ep~=e:GetOwnerPlayer() then return end
	local ct=e:GetLabel()+1
	e:SetLabel(ct)
	if e:GetLabel()==3 then
		local g=Duel.GetFieldGroup(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end