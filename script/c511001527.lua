--Closed Plant Gate
function c511001527.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001527.condition)
	e1:SetOperation(c511001527.activate)
	c:RegisterEffect(e1)
end
function c511001527.cfilter(c,tp)
	return c:IsFaceup() and c:IsRace(RACE_PLANT) and Duel.IsExistingMatchingCard(c511001527.cfilter2,tp,LOCATION_MZONE,0,1,c,c:GetCode())
end
function c511001527.cfilter2(c,code)
	return c:IsFaceup() and c:IsRace(RACE_PLANT) and c:IsCode(code)
end
function c511001527.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001527.cfilter,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c511001527.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetTargetRange(0,LOCATION_MZONE)
	if Duel.GetTurnPlayer()~=tp then
		e1:SetLabel(Duel.GetTurnCount())
		e1:SetCondition(c511001527.skipcon)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	else
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,1)
	end
	Duel.RegisterEffect(e1,tp)
end
function c511001527.skipcon(e)
	return Duel.GetTurnCount()~=e:GetLabel()
end
