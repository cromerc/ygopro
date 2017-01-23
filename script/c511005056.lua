--Reservation Reward
--  By Shad3

local scard=c511005056

function scard.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  c:RegisterEffect(e1)
  --Pierce
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
  e2:SetCode(EVENT_CHAINING)
  e2:SetRange(LOCATION_SZONE)
  e2:SetCondition(scard.cd)
  e2:SetOperation(scard.op)
  c:RegisterEffect(e2)
  --Set
  local e3=Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_IGNITION)
  e3:SetRange(LOCATION_SZONE)
  e3:SetTarget(scard.set_tg)
  e3:SetOperation(scard.set_op)
  e3:SetCountLimit(1)
  c:RegisterEffect(e3)
end

function scard.cd(e,tp,eg,ep,ev,re,r,rp)
  return re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) and re:IsActiveType(TYPE_SPELL) and re:IsActiveType(TYPE_QUICKPLAY)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  local eg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
  local tc=eg:GetFirst()
  while tc do
    if tc:IsFaceup() and tc:IsLocation(LOCATION_MZONE) then
      if not c:IsRelateToCard(tc) then
        c:CreateRelation(tc,RESET_EVENT+0x1fe0000)
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_PIERCE)
        e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        e1:SetCondition(scard.fx_cd)
        tc:RegisterEffect(e1)
      end
      if c:IsRelateToCard(re:GetHandler()) and not c:IsHasCardTarget(tc) then
        c:SetCardTarget(tc)
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_SET_ATTACK_FINAL)
        e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        e1:SetCondition(scard.dbl_cd)
        e1:SetValue(scard.dbl_val)
        tc:RegisterEffect(e1)
      end
    end
    tc=eg:GetNext()
  end
end

function scard.fx_cd(e,c)
  if e:GetOwner():IsRelateToCard(e:GetHandler()) then return e:GetHandler():GetControler()==e:GetOwner():GetControler() end
  e:Reset()
  return false
end

function scard.dbl_cd(e,c)
  if e:GetOwner():IsRelateToCard(e:GetHandler()) then
    local ph=Duel.GetCurrentPhase()
    return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
  end
  e:Reset()
  return false
end

function scard.dbl_val(e,c)
  return c:GetAttack()*2
end

function scard.qui_fil(c)
  return c:IsType(TYPE_SPELL) and c:IsType(TYPE_QUICKPLAY) and c:IsSSetable()
end

function scard.set_tg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.IsExistingMatchingCard(scard.qui_fil,tp,LOCATION_HAND,0,1,nil) end
end

function scard.set_op(e,tp,eg,ep,ev,re,r,rp)
  if not e:GetHandler():IsRelateToEffect(e) then return end
  local tc=Duel.SelectMatchingCard(tp,scard.qui_fil,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
  if tc then
    Duel.SSet(tp,tc)
    tc:SetStatus(STATUS_SET_TURN,false)
    e:GetHandler():CreateRelation(tc,RESET_EVENT+0x1fe0000)
    Duel.RaiseEvent(tc,EVENT_SSET,e,REASON_EFFECT,tp,tp,0)
  end
end