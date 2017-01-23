--Fusion Trench
--  By Shad3
--fixed by MLD
function c511005064.initial_effect(c)
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
	e2:SetTarget(c511005064.atktg)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetCode(EFFECT_DIRECT_ATTACK)
	e3:SetCondition(c511005064.con)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_FUSION))
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(511005064)
	c:RegisterEffect(e4)
	if not c511005064.global_check then
		c511005064.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetOperation(c511005064.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_SPSUMMON_SUCCESS)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_ATTACK_ANNOUNCE)
		ge3:SetOperation(c511005064.checkop2)
		Duel.RegisterEffect(ge3,0)
	end
end
function c511005064.atktg(e,c)
	return not c:IsType(TYPE_FUSION)
end
function c511005064.con(e)
	return Duel.GetFlagEffect(Duel.GetTurnPlayer(),511005064)==0
end
function c511005064.cfilter(c,tp)
	return c:GetSummonPlayer()==tp and (not c:IsType(TYPE_FUSION) or c:IsFacedown())
end
function c511005064.checkop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c511005064.cfilter,1,nil,Duel.GetTurnPlayer()) then
		Duel.RegisterFlagEffect(Duel.GetTurnPlayer(),511005064,RESET_PHASE+PHASE_END,0,1)
	end
end
function c511005064.checkop2(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if a:IsType(TYPE_FUSION) and Duel.GetAttackTarget()==nil and a:IsHasEffect(EFFECT_DIRECT_ATTACK) and a:IsHasEffect(511005064) then
		local e1=Effect.CreateEffect(a)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_DAMAGE_STEP_END)
		e1:SetOperation(c511005064.checkop3)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		a:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EVENT_ATTACK_DISABLED)
		a:RegisterEffect(e2)
	end
end
function c511005064.checkop3(e,tp,eg,ep,ev,re,r,rp)
	Duel.RegisterFlagEffect(Duel.GetTurnPlayer(),511005064,RESET_PHASE+PHASE_END,0,1)
end
