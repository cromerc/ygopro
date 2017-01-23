--Bracer of Power
--  By Shad3

local scard=c511005025

function scard.initial_effect(c)
  --Act
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetProperty(EVENT_FLAG_CARD_TARGET)
  e1:SetCategory(CATEGORY_EQUIP)
  e1:SetTarget(scard.tg)
  e1:SetOperation(scard.op)
  c:RegisterEffect(e1)
  --Equip limit
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_SINGLE)
  e2:SetCode(EFFECT_EQUIP_LIMIT)
  e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
  e2:SetValue(1)
  c:RegisterEffect(e2)
  --Inc ATK
  local e3=Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_EQUIP)
  e3:SetCode(EFFECT_UPDATE_ATTACK)
  e3:SetValue(500)
  c:RegisterEffect(e3)
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:GetLocation()==LOCATION_MZONE and chkc:IsFaceup() end
  if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
  Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
  Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) and tc:IsFaceup() and c:IsRelateToEffect(e) then
    Duel.Equip(tp,c,tc)
  end
end