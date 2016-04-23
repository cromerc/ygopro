--Card of Demise
function c95869691.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_DRAW)
e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c95869691.target)
e1:SetOperation(c95869691.operation)
c:RegisterEffect(e1)
end
function c95869691.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsPlayerCanDraw(tp) end
e:GetHandler():SetTurnCounter(0)
local ht=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
Duel.SetTargetPlayer(tp)
Duel.SetTargetParam(5-ht)
Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,5-ht)
end
function c95869691.operation(e,tp,eg,ep,ev,re,r,rp)
local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
local ht=Duel.GetFieldGroupCount(p,LOCATION_HAND,0)
if(ht<5) then Duel.Draw(p,5-ht,REASON_EFFECT)end
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
e1:SetCountLimit(1)
e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,5)
e1:SetOperation(c95869691.disop)
e1:SetLabel(0)
Duel.RegisterEffect(e1,p)
end
function c95869691.disop(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetTurnPlayer()~=tp then return end
local c=e:GetHandler()
local ct=c:GetTurnCounter()
ct=ct+1
c:SetTurnCounter(ct)
if ct==5 then
local g=Duel.GetFieldGroup(e:GetOwnerPlayer(),LOCATION_HAND,0)
Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
end
end