--Half Shield
--scripted by andré
function c511004335.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511004335.activate)
	c:RegisterEffect(e1) 
end
c511004335[0]=0
c511004335[1]=0
function c511004335.activate(e,tp,eg,ep,ev,re,r,rp)
	c511004335[tp]=1
	if Duel.GetFlagEffect(tp,511004335)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(1)
	e1:SetTargetRange(1,0)
	e1:SetValue(c511004335.val)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE,1)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,511004335,RESET_PHASE+PHASE_DAMAGE,0,1)
end
function c511004335.val(e,re,dam,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 and re and re:IsActiveType(TYPE_MONSTER) and re:GetHandlerPlayer()~=tp then
		e:Reset()
		return dam/2 end
	if bit.band(r,REASON_BATTLE)~=0 then
		e:Reset()
		return dam/2 end
	return dam
end