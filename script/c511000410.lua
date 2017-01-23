--Toon Rollback
function c511000410.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_DISABLED)
	e1:SetTarget(c511000410.target)
	e1:SetOperation(c511000410.activate)
	c:RegisterEffect(e1)
end
function c511000410.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:GetFirst():IsType(TYPE_TOON) and eg:GetFirst():IsControler(tp) end
end
function c511000410.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_BP_TWICE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	if Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()==PHASE_BATTLE then
		e1:SetLabel(Duel.GetTurnCount())
		e1:SetCondition(c511000410.bpcon)
		e1:SetReset(RESET_PHASE+PHASE_BATTLE+RESET_OPPO_TURN,2)
	else
		e1:SetReset(RESET_PHASE+PHASE_BATTLE+RESET_OPPO_TURN,1)
	end
	Duel.RegisterEffect(e1,tp)
end
function c511000410.bpcon(e)
	return Duel.GetTurnCount()~=e:GetLabel()
end