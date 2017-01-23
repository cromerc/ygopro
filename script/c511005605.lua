--Deadman Pirates
--  By Shad3

--[[
Trap/Continuous
Activate this card by targeting 1 "Captain Lock" in your Graveyard; Special Summon it in Attack Position, but its effects are negated. When this card leaves the field, destroy that monster. When that monster leaves the field, destroy this card. Once per turn: You can target 1 monster in your Graveyard; equip it to the monster Special Summoned by this card's effect. That monster gains ATK equal to the combined ATK of the monsters equipped to it by this effect.
--]]

local self=c511005605

function self.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
  e1:SetTarget(self.tg)
  e1:SetOperation(self.op)
  c:RegisterEffect(e1)
  --Destroy
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
  e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
  e2:SetCode(EVENT_LEAVE_FIELD_P)
  e2:SetOperation(self.dis_chk_op)
  c:RegisterEffect(e2)
  local e3=Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
  e3:SetCode(EVENT_LEAVE_FIELD)
  e3:SetOperation(self.des_op)
  e3:SetLabelObject(e2)
  c:RegisterEffect(e3)
  local e4=Effect.CreateEffect(c)
  e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
  e4:SetRange(LOCATION_SZONE)
  e4:SetCode(EVENT_LEAVE_FIELD)
  e4:SetCondition(self.des2_cd)
  e4:SetOperation(self.des2_op)
  c:RegisterEffect(e4)
  --Equip grave
  local e5=Effect.CreateEffect(c)
  e5:SetType(EFFECT_TYPE_QUICK_O)
  e5:SetCode(EVENT_FREE_CHAIN)
  e5:SetCategory(CATEGORY_EQUIP)
  e5:SetRange(LOCATION_SZONE)
  e5:SetCountLimit(1)
  e5:SetTarget(self.eq_tg)
  e5:SetOperation(self.eq_op)
  c:RegisterEffect(e5)
end

function self.fil(c,e,p)
  return c:IsCode(511005604) and c:IsCanBeSpecialSummoned(e,0,p,false,false)
end

function self.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and self.fil(chkc,e,tp) end
  if chk==0 then return Duel.IsExistingTarget(self.fil,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
  local g=Duel.SelectTarget(tp,self.fil,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
  Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,tp,0)
end

function self.op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  local tc=Duel.GetFirstTarget()
  if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK) then
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_DISABLE)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    tc:RegisterEffect(e1,true)
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_DISABLE_EFFECT)
    e2:SetReset(RESET_EVENT+0x1fe0000)
    tc:RegisterEffect(e2,true)
    Duel.SpecialSummonComplete()
    c:SetCardTarget(tc)
  end
end

function self.dis_chk_op(e,tp,eg,ep,ev,re,r,rp)
  if e:GetHandler():IsDisabled() then
    e:SetLabel(1)
  else
    e:SetLabel(0)
  end
end

function self.des_op(e,tp,eg,ep,ev,re,r,rp)
  if e:GetLabelObject():GetLabel()==0 then
    local tc=e:GetHandler():GetFirstCardTarget()
    if tc and tc:IsLocation(LOCATION_MZONE) then
      Duel.Destroy(tc,REASON_EFFECT)
    end
  end
end

function self.des2_cd(e,tp,eg,ep,ev,re,r,rp)
  local tc=e:GetHandler():GetFirstCardTarget()
  return tc and eg:IsContains(tc)
end

function self.des2_op(e,tp,eg,ep,ev,re,r,rp)
  Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end

function self.eq_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and chkc:IsType(TYPE_MONSTER) end
  if chk==0 then
    local ct=e:GetHandler():GetFirstCardTarget()
    return ct and ct:IsLocation(LOCATION_MZONE) and ct:IsFaceup() and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.IsExistingTarget(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_MONSTER)
  end
  local g=Duel.SelectTarget(tp,Card.IsType,tp,LOCATION_GRAVE,0,1,1,nil,TYPE_MONSTER)
  Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
  Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end

function self.eq_op(e,tp,eg,ep,ev,re,r,rp)
  if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
  local c=e:GetHandler()
  local tc=Duel.GetFirstTarget()
  local ct=c:GetFirstCardTarget()
  if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and ct and ct:IsOnField() and ct:IsFaceup() then
    if Duel.Equip(tp,tc,ct,false) then
      local atk=tc:GetTextAttack()
      if atk<0 then atk=0 end
      local e1=Effect.CreateEffect(c)
      e1:SetType(EFFECT_TYPE_SINGLE)
      e1:SetCode(EFFECT_EQUIP_LIMIT)
      e1:SetLabelObject(ct)
      e1:SetValue(function(e,c) return e:GetLabelObject()==c end)
      e1:SetReset(RESET_EVENT+0x1fe0000)
      tc:RegisterEffect(e1)
      local e2=Effect.CreateEffect(c)
      e2:SetType(EFFECT_TYPE_EQUIP)
      e2:SetCode(EFFECT_UPDATE_ATTACK)
      e2:SetValue(atk)
      e2:SetReset(RESET_EVENT+0x1fe0000)
      tc:RegisterEffect(e2)
    end
  end
end