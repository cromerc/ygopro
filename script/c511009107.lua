--Performage Bubble Gardna
function c511009107.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetDescription(aux.Stringid(511001711,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(TIMING_DAMAGE_CAL)
	e3:SetRange(LOCATION_PZONE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetCountLimit(1)
	e3:SetCondition(c511009107.atkcon)
	e3:SetOperation(c511009107.atkop)
	c:RegisterEffect(e3)
	
	--destroy replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c511009107.reptg)
	e4:SetValue(c511009107.repval)
	c:RegisterEffect(e4)
end
function c511009107.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if (phase~=PHASE_DAMAGE and phase~=PHASE_DAMAGE_CAL) or Duel.IsDamageCalculated() then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	local seq=e:GetHandler():GetSequence()
	local pc=Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)
	return d and ((a:GetControler()==tp and a:IsRelateToBattle() )
		or (d:GetControler()==tp and d:IsRelateToBattle())) and pc and pc:IsSetCard(0xc6)
end
function c511009107.atkop(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	if Duel.GetTurnPlayer()~=tp then a=Duel.GetAttackTarget() end
	if not a:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511009107.rdop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
	
	
	-- local e1=Effect.CreateEffect(e:GetHandler())
	-- e1:SetType(EFFECT_TYPE_SINGLE)
	-- e1:SetCode(EFFECT_UPDATE_ATTACK)
	-- e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	-- e1:SetValue(atk)
	-- a:RegisterEffect(e1)
end
function c511009107.rdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,ev/2)
	Duel.ChangeBattleDamage(1-tp,ev/2)
end


----destroy replace
function c511009107.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
		and c:IsSetCard(0xc6) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c511009107.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=eg:FilterCount(c511009107.repfilter,nil,e:GetHandlerPlayer())
	if chk==0 then return ct>0 end
	if Duel.SelectYesNo(tp,aux.Stringid(43175858,0)) then
		return true
	else return false end
end
function c511009107.repval(e,c)
	return c511009107.repfilter(c,e:GetHandlerPlayer())
end

