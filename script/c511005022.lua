--Bond's Reward
--  By Shad3

local scard=c511005022

function scard.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DAMAGE)
	e1:SetTarget(scard.tg)
	e1:SetOperation(scard.op)
	c:RegisterEffect(e1)
end

function scard.fld_fil(c)
  return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end

function scard.grv_fil(c)
  return c:IsAbleToRemove() and c:IsType(TYPE_SYNCHRO)
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsOnField() end
  if chk==0 then return Duel.IsExistingTarget(scard.fld_fil,tp,LOCATION_MZONE,0,1,nil) and Duel.IsExistingMatchingCard(scard.grv_fil,tp,LOCATION_GRAVE,0,1,nil) end
  Duel.SelectTarget(tp,scard.fld_fil,tp,LOCATION_MZONE,0,1,1,nil)
end

function scard.grv_lvl_sum(c)
  return c:GetLevel()*200
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  local tg=Duel.GetFieldGroup(tp,LOCATION_GRAVE,0):Filter(scard.grv_fil,nil)
  if tc:IsRelateToEffect(e) and tg:GetCount()>0 then
    if not Duel.Remove(tg,nil,REASON_EFFECT) then return end
    local i=tg:Filter(Card.IsLocation,nil,LOCATION_REMOVED):GetSum(scard.grv_lvl_sum)
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetValue(i)
    e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    tc:RegisterEffect(e1)
    local e2=Effect.CreateEffect(e:GetHandler())
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e2:SetCode(EVENT_PHASE+PHASE_END)
    e2:SetReset(RESET_PHASE+PHASE_END)
    e2:SetCountLimit(1)
    e2:SetOperation(scard.dmg_op)
    e2:SetLabel(i)
    Duel.RegisterEffect(e2,tp)
  end
end

function scard.dmg_op(e,tp,eg,ep,ev,re,r,rp)
  Duel.Damage(tp,e:GetLabel(),REASON_EFFECT)
end