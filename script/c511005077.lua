--Power Change Barrier
--パサー・チェンジ・バリア
--  By Shad3

local scard=c511005077

function scard.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
  e1:SetTarget(scard.tg)
  e1:SetOperation(scard.op)
  c:RegisterEffect(e1)
  --Negate, Decrease ATK
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
  e2:SetCode(EVENT_CHAIN_ACTIVATING)
  e2:SetRange(LOCATION_SZONE)
  e2:SetCategory(CATEGORY_DISABLE)
  e2:SetCondition(scard.neg_cd)
  e2:SetOperation(scard.neg_op)
  c:RegisterEffect(e2)
  e1:SetLabelObject(e2)
  --Self Destruct
  local e3=Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
  e3:SetCode(EVENT_PHASE+PHASE_END)
  e3:SetRange(LOCATION_SZONE)
  e3:SetOperation(scard.des_op)
  c:RegisterEffect(e3)
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsOnField() and chkc:IsFaceup() end
  if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
  Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  local tc=Duel.GetFirstTarget()
  if not (c:IsRelateToEffect(e) and tc:IsRelateToEffect(e)) then return end
  c:SetCardTarget(tc)
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_SINGLE)
  e1:SetCode(EFFECT_UPDATE_ATTACK)
  e1:SetValue(function(e_,c_) return e_:GetLabel() end)
  e1:SetLabel(0)
  e1:SetReset(RESET_EVENT+0x1fe0000)
  tc:RegisterEffect(e1)
  e:GetLabelObject():SetLabelObject(e1)
end

function scard.neg_cd(e,tp,eg,ep,ev,re,r,rp)
  local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
  local tc=e:GetHandler():GetFirstCardTarget()
  return re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) and g:IsContains(tc)
end

function scard.neg_op(e,tp,eg,ep,ev,re,r,rp)
  Duel.NegateEffect(ev)
  local ne=e:GetLabelObject()
  ne:SetLabel(ne:GetLabel()-600)
end

function scard.des_op(e,tp,eg,ep,ev,re,r,rp)
  Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end