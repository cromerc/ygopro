--Ｓｐ－アクセル・リミッター
function c100100108.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c100100108.activate)
	c:RegisterEffect(e1)
end
function c100100108.turncon1(e)
	return Duel.GetTurnPlayer()~=e:GetHandlerPlayer() and Duel.GetTurnCount()~=e:GetLabel() and Duel.GetCurrentPhase()==PHASE_STANDBY
end
function c100100108.turncon2(e)
	return Duel.GetTurnPlayer()~=e:GetHandlerPlayer() and Duel.GetCurrentPhase()==PHASE_STANDBY
end
function c100100108.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(100100090)
	e1:SetTargetRange(0,1)
	if Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()==PHASE_STANDBY then
		e1:SetLabel(Duel.GetTurnCount())
		e1:SetCondition(c100100108.turncon1)
		e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_OPPO_TURN,3)
	else
		e1:SetCondition(c100100108.turncon2)
		e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_OPPO_TURN,2)
	end
	e1:SetValue(1)
	Duel.RegisterEffect(e1,tp)
end
