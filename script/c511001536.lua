--Advance Carnival
function c511001536.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511001536.activate)
	c:RegisterEffect(e1)
	if not c511001536.global_check then
		c511001536.global_check=true
		c511001536[0]=false
		c511001536[1]=false
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetOperation(c511001536.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511001536.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511001536.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if bit.band(tc:GetSummonType(),SUMMON_TYPE_ADVANCE)==SUMMON_TYPE_ADVANCE then
			c511001536[tc:GetControler()]=true
		end
		tc=eg:GetNext()
	end
end
function c511001536.clear(e,tp,eg,ep,ev,re,r,rp)
	c511001536[0]=false
	c511001536[1]=false
end
function c511001536.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,511001536)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetCondition(c511001536.con)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsLevelAbove,5))
	e1:SetValue(0x1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,511001536,RESET_PHASE+PHASE_END,0,1)
end
function c511001536.con(e)
	return c511001536[e:GetHandlerPlayer()]
end
