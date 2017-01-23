--Performapal Reborn Force
--復活のエンタメ－リボーン・フォース－
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
  e1:SetCondition(scard.cd)
  e1:SetOperation(scard.op)
  c:RegisterEffect(e1)
  --Global check
  if not scard.gl_chk then
    scard.gl_chk=true
    scard.sreg={}
    local ge1=Effect.GlobalEffect()
    ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    ge1:SetCode(EVENT_DESTROYED)
    ge1:SetOperation(scard.reg_op)
    Duel.RegisterEffect(ge1,0)
    local ge2=Effect.GlobalEffect()
    ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    ge2:SetCode(EVENT_TURN_END)
    ge2:SetOperation(scard.rst_op)
    Duel.RegisterEffect(ge2,0)
  end
end

function scard.reg_op(e,tp,eg,ep,ev,re,r,rp)
  local tc=eg:GetFirst()
  while tc do
    if tc:IsType(TYPE_MONSTER) and tc:IsSetCard(0x9f) then scard.sreg[tc:GetPreviousControler()]=true end
    tc=eg:GetNext()
  end
end

function scard.rst_op()
  scard.sreg[0]=false
  scard.sreg[1]=false
end

function scard.cd(e,tp,eg,ep,ev,re,r,rp)
  return scard.sreg[tp]
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
  local e1=Effect.CreateEffect(e:GetHandler())
  e1:SetType(EFFECT_TYPE_FIELD)
  e1:SetCode(EFFECT_REFLECT_DAMAGE)
  e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
  e1:SetTargetRange(1,0)
  e1:SetValue(scard.ref_val)
  e1:SetReset(RESET_PHASE+PHASE_END)
  Duel.RegisterEffect(e1,tp)
  if (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE) then
    Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
  end
end

function scard.ref_val(e,re,val,r,rp,rc)
  if bit.band(r,REASON_EFFECT)~=0 then
    e:Reset()
    return true
  end
  return false
end