--Scripted by Eerie Code
--Goyo Defender
function c700000003.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c700000003.spcon)
	e1:SetOperation(c700000003.spop)
	c:RegisterEffect(e1)
	--Change ATK
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O+EFFECT_TYPE_FIELD)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCondition(c700000003.atkcon)
	e2:SetCost(c700000003.atkcost)
	e2:SetOperation(c700000003.atkop)
	c:RegisterEffect(e2)
	--Destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c700000003.descon)
	e3:SetTarget(c700000003.destg)
	e3:SetOperation(c700000003.desop)
	c:RegisterEffect(e3)
end

function c700000003.cfilter(c)
	return c:IsFacedown() or not c:IsCode(700000003)
end
function c700000003.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0
		and not Duel.IsExistingMatchingCard(c700000003.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c700000003.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e1:SetReset(RESET_EVENT+0xfe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end

function c700000003.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget() and Duel.GetAttackTarget()==e:GetHandler()
end
function c700000003.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(700000003)==0 end
	e:GetHandler():RegisterFlagEffect(700000003,RESET_PHASE+RESET_DAMAGE_CAL,0,1)
end
function c700000003.atkfil(c)
	return c:IsFaceup() and c:IsCode(700000003)
end
function c700000003.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_DAMAGE_CAL)
	e1:SetValue(c700000003.atkval)
	c:RegisterEffect(e1)
end
function c700000003.atkval(e,c)
	--return Duel.GetFieldGroupCount(c700000003.atkfil,LOCATION_MZONE,0)*1000
	return Duel.GetMatchingGroupCount(c700000003.atkfil,e:GetHandlerPlayer(),LOCATION_MZONE,LOCATION_MZONE,nil)*1000
end

function c700000003.descon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetReason(),0x41)==0x41
end
function c700000003.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c700000003.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	Duel.Destroy(g,REASON_EFFECT)
end