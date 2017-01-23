--Climactic Barricade
function c511000054.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c511000054.operation)
	c:RegisterEffect(e1)
end
function c511000054.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(c511000054.atktarget)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,tp)
	--Damage LP
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetOperation(c511000054.damop)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c511000054.atktarget(e,c)
	return c:GetLevel()<=4
end
function c511000054.filter(c)
	return c:IsFaceup() and c:GetLevel()<=4
end
function c511000054.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511000054)
	local dam=Duel.GetMatchingGroupCount(c511000054.filter,tp,0,LOCATION_MZONE,nil)*500
	Duel.Damage(1-tp,dam,REASON_EFFECT)
end
