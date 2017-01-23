--Violet Flash
function c511001503.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511001503.activate)
	c:RegisterEffect(e1)
end
function c511001503.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetOperation(c511001503.chainop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c511001503.drcon)
	e2:SetOperation(c511001503.drop)
	e2:SetCountLimit(1)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c511001503.chainop(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and rc:IsSetCard(0x46) and re:IsActiveType(TYPE_SPELL) then
		Duel.SetChainLimit(c511001503.chainlm)
	end
end
function c511001503.chainlm(e,rp,tp)
	return rp==tp or not e:GetHandler():IsType(TYPE_SPELL+TYPE_TRAP)
end
function c511001503.filter(c,tp)
	return c:IsControler(tp) and bit.band(c:GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c511001503.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001503.filter,1,nil,tp)
end
function c511001503.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511001503)
	Duel.Draw(tp,1,REASON_EFFECT)
end
