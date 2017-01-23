--Goyo Defender
function c511001743.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c511001743.spcon)
	e1:SetOperation(c511001743.spop)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--spsummon condition
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c511001743.con)
	e2:SetOperation(c511001743.op)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetDescription(aux.Stringid(511000034,0))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(TIMING_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetCondition(c511001743.atkcon)
	e3:SetTarget(c511001743.atktg)
	e3:SetOperation(c511001743.atkop)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511001743,1))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCondition(c511001743.descon)
	e4:SetTarget(c511001743.destg)
	e4:SetOperation(c511001743.desop)
	c:RegisterEffect(e4)
end
function c511001743.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0
		and not Duel.IsExistingMatchingCard(c511001743.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511001743.cfilter(c)
	return c:IsFacedown() or not c:IsCode(511001743)
end
function c511001743.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e1:SetReset(RESET_EVENT+0xfe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end
function c511001743.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+1
end
function c511001743.op(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():SetStatus(STATUS_PROC_COMPLETE,false)
end
function c511001743.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if (phase~=PHASE_DAMAGE and phase~=PHASE_DAMAGE_CAL) or Duel.IsDamageCalculated() then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return a:GetControler()~=tp and d and d==e:GetHandler()
end
function c511001743.filter(c)
	return c:IsFaceup() and c:IsCode(511001743)
end
function c511001743.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001743.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) 
		and e:GetHandler():GetFlagEffect(511001743)==0 end
	e:GetHandler():RegisterFlagEffect(511001743,RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c511001743.atkop(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local atk=Duel.GetMatchingGroupCount(c511001743.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)*1000
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(atk)
		c:RegisterEffect(e1)
	end
end
function c511001743.descon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetReason(),0x41)==0x41
end
function c511001743.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c511001743.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	Duel.Destroy(sg,REASON_EFFECT)
end
