--Shadow Clone Zone
--多分影分身
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
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
  e1:SetCategory(CATEGORY_EQUIP)
  e1:SetTarget(scard.tg)
  e1:SetOperation(scard.op)
  c:RegisterEffect(e1)
  --Equip limit
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_SINGLE)
  e2:SetCode(EFFECT_EQUIP_LIMIT)
  e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
  e2:SetValue(scard.eq_lmt)
  c:RegisterEffect(e2)
  --Add ATK
  local e3=Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
  e3:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
  e3:SetRange(LOCATION_SZONE)
  e3:SetCountLimit(1)
  e3:SetTarget(scard.at_tg)
  e3:SetOperation(scard.at_op)
  c:RegisterEffect(e3)
end

function scard.eq_fil(c)
  return c:IsFaceup() and c:GetLevel()==3
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:GetLocation()==LOCATION_MZONE and scard.eq_fil(chkc) end
  if chk==0 then return Duel.IsExistingTarget(scard.eq_fil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
  Duel.SelectTarget(tp,scard.eq_fil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
  Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) and tc:IsFaceup() and c:IsRelateToEffect(e) then
    Duel.Equip(tp,c,tc)
  end
end

function scard.eq_lmt(e,c)
  return c:GetLevel()==3
end

function scard.check_def(p)
  local g=Duel.GetMatchingGroup(Card.IsFaceup,p,0,LOCATION_MZONE,nil)
  if g:GetCount()==0 then return 0 end
  local tc=g:GetFirst()
  local n=0
  local defs={}
  while tc do
    local d=tc:GetDefense()
    local v=defs[d]
    if v then
      v=v+1
      if v==2 then n=n+1 end
      n=n+1
      defs[d]=v
    else
      defs[d]=1
    end
    tc=g:GetNext()
  end
  return n
end

function scard.at_tg(e,tp,eg,ep,ev,re,r,rp,chk)
  local n=scard.check_def(tp)
  if chk==0 then return n>1 end
  e:SetLabel(n)
end

function scard.at_op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  if not c:IsRelateToEffect(e) then return end
  local n=e:GetLabel()
  if n>1 then
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_EQUIP)
    e1:SetCode(EFFECT_EXTRA_ATTACK)
    e1:SetValue(n-1)
    e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
    c:RegisterEffect(e1)
  end
end