--Cursed Chaos
function c511001492.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--selfdes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetCondition(c511001492.sdcon)
	c:RegisterEffect(e2)
	--pay
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_ACTIVATE_COST)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(0,1)
	e3:SetTarget(c511001492.actarget)
	e3:SetCost(c511001492.costchk)
	e3:SetOperation(c511001492.costop)
	c:RegisterEffect(e3)
end
function c511001492.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x1048)
end
function c511001492.sdcon(e)
	return not Duel.IsExistingMatchingCard(c511001492.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c511001492.actarget(e,te,tp)
	return te:IsActiveType(TYPE_MONSTER)
end
function c511001492.costchk(e,te_or_c,tp)
	return Duel.CheckLPCost(tp,500)
end
function c511001492.costop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PayLPCost(tp,500)
end
