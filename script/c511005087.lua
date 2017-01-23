--Magic Rebounder
--マジック・リバウンダー
--  By Shad3

local function getID()
  local str=string.match(debug.getinfo(2,'S')['source'],"c%d+%.lua")
  str=string.sub(str,1,string.len(str)-4)
  local scard=_G[str]
  local s_id=tonumber(string.sub(str,2))
  return scard,s_id
end

local scard,s_id=getID()

function scard.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
  e1:SetCondition(scard.cd)
  e1:SetTarget(scard.tg)
  e1:SetOperation(scard.op)
  c:RegisterEffect(e1)
end

function scard.cd(e,tp,eg,ep,ev,re,r,rp)
  return Duel.GetAttacker():IsControler(1-tp) and Duel.GetBattleDamage(tp)>0
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  Duel.SetOperationInfo(0,CATEGORY_DESTROY,Group.FromCards(Duel.GetAttacker()),1,tp,0)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetAttacker()
  if tc and tc:IsOnField() then
    Duel.Destroy(tc,REASON_EFFECT)
  end
end