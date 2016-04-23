--スリップ・ストリーム
function c100100154.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetOperation(c100100154.op)
	c:RegisterEffect(e1)
end
function c100100154.op(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCountLimit(1)
	e1:SetLabel(Duel.GetTurnCount())
	e1:SetCondition(c100100154.spcon)
	e1:SetOperation(c100100154.spop)
	if Duel.GetTurnPlayer()==tp then
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
	else
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,1)
	end
	Duel.RegisterEffect(e1,tp)
end
function c100100154.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()>=e:GetLabel() and Duel.GetTurnPlayer()==tp
end
function c100100154.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	local tc2=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
	if tc2:GetCounter(0x91)>tc1:GetCounter(0x91) then
		tc1:RegisterFlagEffect(100100103,RESET_EVENT+RESET_CHAIN,0,1)
		tc1:AddCounter(0x91,tc2:GetCounter(0x91)-tc1:GetCounter(0x91))	
	end
end