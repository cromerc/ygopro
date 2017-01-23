--Shield Coat
function c511002584.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c511002584.condition)
	e1:SetTarget(c511002584.target)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--Double DEF
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsPosition,POS_FACEUP_DEFENSE))
	e4:SetValue(c511002584.defval)
	c:RegisterEffect(e4)
end
function c511002584.cfilter(c,tp)
	return c:GetSummonPlayer()~=tp and c:IsFaceup() 
		and Duel.IsExistingMatchingCard(c511002584.filter,tp,LOCATION_MZONE,0,1,nil,c:GetAttack())
end
function c511002584.filter(c,atk)
	return c:IsFaceup() and atk>c:GetDefense()
end
function c511002584.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002584.cfilter,1,nil,tp)
end
function c511002584.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	c:SetTurnCounter(0)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511002584.descon)
	e2:SetOperation(c511002584.desop)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,2)
	c:RegisterEffect(e2)
end
function c511002584.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511002584.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if ct==2 then
		Duel.Destroy(c,REASON_RULE)
	end
end
function c511002584.defval(e,c)
	return c:GetDefense()*2
end
