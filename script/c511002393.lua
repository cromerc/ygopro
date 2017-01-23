--Ability Limitation
function c511002393.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e2)
	--pay
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_ACTIVATE_COST)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,1)
	e3:SetTarget(c511002393.actarget)
	e3:SetCost(c511002393.costchk)
	e3:SetOperation(c511002393.costop)
	c:RegisterEffect(e3)
end
function c511002393.actarget(e,te,tp)
	return te:IsActiveType(TYPE_MONSTER)
end
function c511002393.costchk(e,te_or_c,tp)
	return Duel.CheckLPCost(tp,500)
end
function c511002393.costop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PayLPCost(tp,500)
end
