--Dice Dungeon
function c24648246.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c24648246.clear)
	c:RegisterEffect(e1)
	local ng=Group.CreateGroup()
	ng:KeepAlive()
	e1:SetLabelObject(ng)
	--selfdestroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c24648246.sdop)
	c:RegisterEffect(e2)
	--ATK change
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(87902575,0))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetCondition(c24648246.condition)
	e3:SetTarget(c24648246.target)
	e3:SetOperation(c24648246.operation)
	c:RegisterEffect(e3)
end
function c24648246.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()
end
function c24648246.clear(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:GetLabelObject():Clear()
end
function c24648246.descon(e)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c24648246.sdop(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
if g:GetCount()==0 then
Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
end
function c24648246.target(e,tp,eg,ep,ev,re,r,rp,chk)
local a=Duel.GetAttacker()
local d=Duel.GetAttackTarget()
if chk==0 then return d:IsFaceup() and d:IsCanBeEffectTarget(e) and d:IsOnField()  and  a:IsFaceup() and a:IsCanBeEffectTarget(e) and a:IsOnField()  end
Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,PLAYER_AL,1)
end
function c24648246.operation(e,tp,eg,ep,ev,re,r,rp)
local a=Duel.GetAttacker()
local d=Duel.GetAttackTarget()
if not e:GetHandler():IsRelateToEffect(e) then return end
local dice=Duel.TossDice(tp,1)
if dice==1 then
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_UPDATE_ATTACK)
e1:SetReset(RESET_PHASE+RESET_DAMAGE_CAL)
e1:SetValue(-1000)
a:RegisterEffect(e1)
elseif dice==2 then
local e2=Effect.CreateEffect(e:GetHandler())
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_UPDATE_ATTACK)
e2:SetReset(RESET_PHASE+RESET_DAMAGE_CAL)
e2:SetValue(1000)
a:RegisterEffect(e2)
elseif dice==3 then
local e3=Effect.CreateEffect(e:GetHandler())
e3:SetType(EFFECT_TYPE_SINGLE)
e3:SetCode(EFFECT_UPDATE_ATTACK)
e3:SetReset(RESET_PHASE+RESET_DAMAGE_CAL)
e3:SetValue(0)
a:RegisterEffect(e3)
elseif dice==4 then
local e4=Effect.CreateEffect(e:GetHandler())
e4:SetType(EFFECT_TYPE_SINGLE)
e4:SetCode(EFFECT_SET_ATTACK)
e4:SetReset(RESET_PHASE+RESET_DAMAGE_CAL)
e4:SetValue(0)
a:RegisterEffect(e4)	
else if dice==5 then
local e5=Effect.CreateEffect(e:GetHandler())
e5:SetType(EFFECT_TYPE_SINGLE)
e5:SetCode(EFFECT_SET_BASE_ATTACK)
e5:SetReset(RESET_PHASE+RESET_DAMAGE_CAL)
e5:SetValue(a:GetBaseAttack()/2)
a:RegisterEffect(e5)
else
local e6=Effect.CreateEffect(e:GetHandler())
e6:SetType(EFFECT_TYPE_SINGLE)
e6:SetCode(EFFECT_SET_BASE_ATTACK)
e6:SetReset(RESET_PHASE+RESET_DAMAGE_CAL)
e6:SetValue(a:GetAttack()*2)
a:RegisterEffect(e6)
end
end
dice=Duel.TossDice(1-tp,1)
if dice==1 then
local e7=Effect.CreateEffect(e:GetHandler())
e7:SetType(EFFECT_TYPE_SINGLE)
e7:SetCode(EFFECT_UPDATE_ATTACK)
e7:SetReset(RESET_PHASE+RESET_DAMAGE_CAL)
e7:SetValue(-1000)
d:RegisterEffect(e7)
elseif dice==2 then
local e8=Effect.CreateEffect(e:GetHandler())
e8:SetType(EFFECT_TYPE_SINGLE)
e8:SetCode(EFFECT_UPDATE_ATTACK)
e8:SetReset(RESET_PHASE+RESET_DAMAGE_CAL)
e8:SetValue(1000)
d:RegisterEffect(e8)
elseif dice==3 then
local e9=Effect.CreateEffect(e:GetHandler())
e9:SetType(EFFECT_TYPE_SINGLE)
e9:SetCode(EFFECT_UPDATE_ATTACK)
e9:SetReset(RESET_PHASE+RESET_DAMAGE_CAL)
e9:SetValue(0)
d:RegisterEffect(e9)
elseif dice==4 then
local e10=Effect.CreateEffect(e:GetHandler())
e10:SetType(EFFECT_TYPE_SINGLE)
e10:SetCode(EFFECT_SET_ATTACK)
e10:SetReset(RESET_PHASE+RESET_DAMAGE_CAL)
e10:SetValue(0)
d:RegisterEffect(e10)	
else if dice==5 then
local e11=Effect.CreateEffect(e:GetHandler())
e11:SetType(EFFECT_TYPE_SINGLE)
e11:SetCode(EFFECT_SET_BASE_ATTACK)
e11:SetReset(RESET_PHASE+RESET_DAMAGE_CAL)
e11:SetValue(d:GetBaseAttack()/2)
d:RegisterEffect(e11)
else
local e12=Effect.CreateEffect(e:GetHandler())
e12:SetType(EFFECT_TYPE_SINGLE)
e12:SetCode(EFFECT_SET_BASE_ATTACK)
e12:SetReset(RESET_PHASE+RESET_DAMAGE_CAL)
e12:SetValue(d:GetAttack()*2)
d:RegisterEffect(e12)
end
end
end