--cosmo queen (DOR)
--scripted by GameMaster (GM)
function c511005625.initial_effect(c)
  --flip
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
  e1:SetOperation(c511005625.op)
  c:RegisterEffect(e1)
end

function c511005625.filter(c)
  return c and c:IsFaceup()
end
function c511005625.condition(e)
  return
   not c511005625.filter(Duel.GetFieldCard(0,LOCATION_SZONE,5)) and
   not c511005625.filter(Duel.GetFieldCard(1,LOCATION_SZONE,5))
end

function c511005625.op(e)
  local c=e:GetHandler()
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_FIELD)
  e1:SetCode(EFFECT_UPDATE_ATTACK)
  e1:SetRange(LOCATION_MZONE)
  e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
  e1:SetCondition(c511005625.condition)
  e1:SetValue(c511005625.val)
  e1:SetReset(RESET_EVENT+0x1fe0000)
  c:RegisterEffect(e1)
  --Def
  local e2=e1:Clone()
  e2:SetCode(EFFECT_UPDATE_DEFENSE)
  c:RegisterEffect(e2)
  --field
  local e3=Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_FIELD)
  e3:SetCode(EFFECT_CHANGE_ENVIRONMENT)
  e3:SetRange(LOCATION_MZONE)
  e3:SetCondition(c511005625.condition)
  e3:SetValue(59197169)
  e1:SetReset(RESET_EVENT+0x1fe0000)
  c:RegisterEffect(e3)
end

function c511005625.val(e,c)
  local r=c:GetRace()
  if bit.band(r,RACE_FIEND+RACE_SPELLCASTER)>0 then return 200
  elseif bit.band(r,RACE_FAIRY)>0 then return -200
  else return 0 end
end