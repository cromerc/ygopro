--Mischief of the Time Goddess
function c511001133.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511001133.activate)
	c:RegisterEffect(e1)
end
function c511001133.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_SKIP_TURN)
	e1:SetTargetRange(0,1)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetCode(EFFECT_SKIP_M2)
	if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_STANDBY then
	e2:SetCondition(c511001133.skipcon)
		e2:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,2)
	else
		e2:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
		end
		Duel.RegisterEffect(e2,tp)
		local e3=e2:Clone()
		e3:SetCode(EFFECT_CANNOT_EP)
        Duel.RegisterEffect(e3,tp)
        local e4=e3:Clone()
		e4:SetCode(EFFECT_CANNOT_BP)
        Duel.RegisterEffect(e4,tp)
    local e5=Effect.CreateEffect(e:GetHandler())
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetTargetRange(1,0)
	e5:SetCode(EFFECT_SKIP_DP)
	if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_BATTLE then
		e5:SetCondition(c511001133.skipcon)
		e5:SetLabel(Duel.GetTurnCount())
		e5:SetReset(RESET_PHASE+PHASE_BATTLE+RESET_SELF_TURN,2)
	else
		e5:SetReset(RESET_PHASE+PHASE_BATTLE+RESET_SELF_TURN)
	end
	Duel.RegisterEffect(e5,tp)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_SKIP_SP)
	Duel.RegisterEffect(e6,tp)
	local e7=e6:Clone()
	e7:SetCode(EFFECT_SKIP_M1)
	Duel.RegisterEffect(e7,tp)
	local e8=e7:Clone()
	e8:SetCode(EFFECT_CANNOT_EP)
	e8:SetTargetRange(1,0)
	if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_MAIN1 then
		e8:SetReset(RESET_PHASE+PHASE_MAIN1,2)
	else
		e8:SetReset(RESET_PHASE+PHASE_MAIN1)
	end
	Duel.RegisterEffect(e8,tp)
end
function c511001133.skipcon(e)
	return Duel.GetTurnCount()~=e:GetLabel()
end
