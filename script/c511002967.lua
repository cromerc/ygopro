--Amazoness Curse Mirror
function c511002967.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_END_PHASE)
	e1:SetCondition(c511002967.condition)
	c:RegisterEffect(e1)
	--no damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511002967.op)
	c:RegisterEffect(e1)
	if not c511002967.global_check then
		c511002967.global_check=true
		c511002967[0]=true
		c511002967[1]=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_BATTLE_DAMAGE)
		ge1:SetOperation(c511002967.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511002967.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002967.checkop(e,tp,eg,ep,ev,re,r,rp)
	c511002967[ep]=true
end
function c511002967.clear(e,tp,eg,ep,ev,re,r,rp)
	c511002967[0]=false
	c511002967[1]=false
end
function c511002967.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_END and c511002967[tp]
end
function c511002967.op(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp and e:GetHandler():GetFlagEffect(511002967)==0 and Duel.SelectYesNo(tp,aux.Stringid(93816465,1)) then
		e:GetHandler():RegisterFlagEffect(511002967,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		Duel.ChangeBattleDamage(tp,0)
	end
end
