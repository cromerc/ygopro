--Otonari Thunder
--  By Shad3

local scard=c511005013

function scard.initial_effect(c)
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_FIELD)
  e1:SetCode(EFFECT_SPSUMMON_PROC)
  e1:SetRange(LOCATION_DECK)
  e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
  e1:SetCondition(scard.sum_cd)
  e1:SetOperation(scard.sum_op)
  c:RegisterEffect(e1)
end

if not scard.Set_hunder then
  scard.Set_hunder={ --This should be replaced when there's 'hunder' archetype
    [21524779]=true, --Mahunder
    [84530620]=true, --Pahunder
    [57019473]=true, --Sishunder
    [48049769]=true, --Thunder Seahorse
    [84417082]=true, --Number 91
    [511002059]=true, --Number 91 (A)
    [511005003]=true, --Brohunder
    [511005013]=true --Otonari Thunder (this!)
    --Rolling Thunder, Thunder Mountain to be added
  }
  
  for _,i in ipairs{
    71438011,78663366,61204971,34961968,
    698785,15510988,31786629,54752875,
    77506119,987311,50920465,14089428,
    21817254
  } do
    scard.Set_hunder[i]=true
  end
end

function scard.hunder_fil(c)
  return c:IsFaceup() and scard.Set_hunder[c:GetCode()]
end

function scard.sum_cd(e,c)
  if not c then return true end
  local tp=c:GetControler()
  return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsAnyMatchingCard(tp,scard.hunder_fil,LOCATION_MZONE,0,4,nil)
end

function scard.sum_op(e,tp,eg,ep,ev,re,r,rp,c)
  Duel.ShuffleDeck(tp)
end