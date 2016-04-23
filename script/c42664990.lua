--Card of Sanctity
function c42664990.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_DRAW)
e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c42664990.target)
e1:SetOperation(c42664990.operation)
c:RegisterEffect(e1)
end
function c42664990.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsPlayerCanDraw(tp) end
local ht=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
Duel.SetTargetPlayer(tp,1-tp)
Duel.SetTargetParam(6-ht)
Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,1-tp,tp,6-ht)
end
function c42664990.operation(e,tp,eg,ep,ev,re,r,rp)
local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
local ht=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
if(ht<6) then 
Duel.Draw(tp,6-ht,REASON_EFFECT)
end
local ht=Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)
if(ht<6) then 
Duel.Draw(1-tp,6-ht,REASON_EFFECT)
end
end
