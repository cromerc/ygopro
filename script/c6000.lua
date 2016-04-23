--Scripted by Eerie Code
--Antihope, the God of Despair
function c6000.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e2:SetCondition(c6000.spcon)
	e2:SetOperation(c6000.spop)
	c:RegisterEffect(e2)
	--cannot attack announce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c6000.antarget)
	c:RegisterEffect(e3)
	--Invincible
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(6000,0))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetHintTiming(TIMING_BATTLE_PHASE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c6000.incon)
	e4:SetCost(c6000.incost)
	e4:SetOperation(c6000.inop)
	c:RegisterEffect(e4)
end

function c6000.spfilter(c)
	return c:IsFaceup() and c:GetLevel()==1 and c:IsAbleToGraveAsCost()
end
function c6000.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-4 and Duel.IsExistingMatchingCard(c6000.spfilter,c:GetControler(),LOCATION_MZONE,0,4,nil)
end
function c6000.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c6000.spfilter,c:GetControler(),LOCATION_MZONE,0,4,4,nil)
	Duel.SendtoGrave(g,REASON_COST)
end

function c6000.antarget(e,c)
	return c~=e:GetHandler()
end

function c6000.infil(c)
	return c:IsType(TYPE_MONSTER) and c:GetLevel()==1 and c:IsAbleToRemoveAsCost()
end
function c6000.incon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bt=Duel.GetAttacker()
	if bt and bt==c then return not c:IsStatus(STATUS_CHAINING) end
	bt=Duel.GetAttackTarget()
	return bt and bt==c and not c:IsStatus(STATUS_CHAINING)
end
function c6000.incost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(6000)==0 and Duel.IsExistingMatchingCard(c6000.infil,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c6000.infil,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:GetHandler():RegisterFlagEffect(6000,RESET_PHASE+RESET_DAMAGE_CAL,0,1)
end
function c6000.inop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c6000.efilter)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	c:RegisterEffect(e2)
end
function c6000.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end