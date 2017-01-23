--サッド・ストーリー ～忌むべき日～
function c100000098.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)	
	e1:SetOperation(c100000098.actlimit)
	c:RegisterEffect(e1)	
	--DP
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DRAW)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c100000098.ctcon)
	e2:SetOperation(c100000098.ctop)
	c:RegisterEffect(e2)
end
function c100000098.actlimit(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetValue(c100000098.elimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c100000098.elimit(e,te,tp)
	return te:GetHandler():IsType(TYPE_SPELL)
end
function c100000098.eqfilter(c)
	return c:IsType(TYPE_TRAP)
end
function c100000098.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_DRAW and eg:IsExists(c100000098.eqfilter,1,nil)
end
function c100000098.ctop(e,tp,eg,ep,ev,re,r,rp)
	if eg then
		Duel.ConfirmCards(Duel.GetTurnPlayer(),eg)
		Duel.SendtoDeck(eg,nil,2,REASON_EFFECT)
	end
end
