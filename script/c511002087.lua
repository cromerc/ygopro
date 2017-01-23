--Gravity Gain
function c511002087.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c511002087.atktarget)
	c:RegisterEffect(e2)
	--maintain
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511002087.mtcon)
	e3:SetOperation(c511002087.mtop)
	c:RegisterEffect(e3)
end
function c511002087.atktarget(e,c)
	return c:GetLevel()<=4
end
function c511002087.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511002087.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CheckReleaseGroup(tp,nil,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(63014935,2)) then
		local sg=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
		Duel.Release(sg,REASON_COST)
	else
		Duel.Destroy(e:GetHandler(),REASON_RULE)
	end
end
