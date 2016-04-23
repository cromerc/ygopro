--Divine Serpent
--By Jackmoonward
function c170000170.initial_effect(c)
c:EnableReviveLimit()
--cannot special summon
local e1=Effect.CreateEffect(c)
e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_SPSUMMON_CONDITION)
c:RegisterEffect(e1)
--Cannot Lose
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD)
e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e2:SetRange(LOCATION_MZONE) 
e2:SetTargetRange(1,0)
e2:SetValue(0)
c:RegisterEffect(e2)
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_FIELD)
e3:SetCode(EFFECT_DRAW_COUNT)
e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e3:SetRange(LOCATION_MZONE) 
e3:SetTargetRange(1,0)
e3:SetValue(c170000170.dc)
c:RegisterEffect(e3)
--spsummon success
local e4=Effect.CreateEffect(c)
e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e4:SetCode(EVENT_SPSUMMON_SUCCESS)
e4:SetOperation(c170000170.sucop)
c:RegisterEffect(e4)
--attack cost
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_SINGLE)
e5:SetCode(EFFECT_ATTACK_COST)
e5:SetCost(c170000170.atcost)
e5:SetOperation(c170000170.atop)
c:RegisterEffect(e5)
--damage reduce
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_FIELD)
e6:SetCode(EFFECT_CHANGE_DAMAGE)
e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e6:SetRange(LOCATION_MZONE)
e6:SetTargetRange(1,0)
e6:SetValue(c170000170.damval)
c:RegisterEffect(e6)
--damage reduce
local e7=Effect.CreateEffect(c)
e7:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
e7:SetRange(LOCATION_MZONE)
e7:SetCode(EVENT_PRE_BATTLE_DAMAGE)
e7:SetCondition(c170000170.rdcon)
e7:SetOperation(c170000170.rdop)
c:RegisterEffect(e7)
end
function c170000170.dc(e)
local tp=e:GetHandler():GetControler()
if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 then
return 1
else
return 0
end
end
function c170000170.sucop(e,tp,eg,ep,ev,re,r,rp)
Duel.SetLP(tp,0) 
Duel.SetLP(tp,1)
local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
Duel.SendtoGrave(g,REASON_EFFECT)
--lose
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
e1:SetCode(EVENT_LEAVE_FIELD)
e1:SetCondition(c170000170.losecon)
e1:SetOperation(c170000170.lose)
e:GetHandler():RegisterEffect(e1)
end
function c170000170.atcost(e,c,tp)
	return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=10
end
function c170000170.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,10,REASON_COST)
end
function c170000170.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 then return 0 end
	return val
end
function c170000170.rdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttackTarget() or e:GetHandler()==Duel.GetAttacker()
end
function c170000170.rdop(e,tp,eg,ep,ev,re,r,rp)
local X=Duel.GetLP(1-tp)
Duel.ChangeBattleDamage(ep,X)
end
function c170000170.losecon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=1
	end
function c170000170.lose(e,tp,eg,ep,ev,re,r,rp)
    Duel.SetLP(tp,0)
end