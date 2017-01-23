--Action Card - Stand Up
function c95000098.initial_effect(c)
--reflect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c95000098.condition)
	e1:SetOperation(c95000098.operation)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetCondition(c95000098.handcon)
	c:RegisterEffect(e2)
end
function c95000098.condition(e,tp,eg,ep,ev,re,r,rp)
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if ex then return true end
	ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
	return ex and Duel.GetTurnPlayer()~=tp
end
function c95000098.operation(e,tp,eg,ep,ev,re,r,rp)
	local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetLabel(cid)
	e1:SetValue(c95000098.refcon)
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
	local sk=Duel.GetTurnPlayer()
	Duel.BreakEffect()
	Duel.SkipPhase(sk,PHASE_DRAW,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(sk,PHASE_STANDBY,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(sk,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(sk,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
    Duel.SkipPhase(sk,PHASE_MAIN2,RESET_PHASE+PHASE_MAIN2,1)
    Duel.SkipPhase(sk,PHASE_END,RESET_PHASE+PHASE_END,1)
end
function c95000098.refcon(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return end
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	if cid==e:GetLabel() then return 0 end
	return val
end

function c95000098.handcon(e)
	return tp~=Duel.GetTurnPlayer()
end


