--Remember Attack
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
  --Flag to avoid infinite loop
  scard['no_react_ev']=true
  --Global reg
  if not scard['gl_reg'] then
    scard['gl_reg']=true
    local ge1=Effect.GlobalEffect()
    ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    ge1:SetCode(EVENT_CHAIN_NEGATED)
    ge1:SetOperation(scard.flag_op)
    Duel.RegisterEffect(ge1,0)
  end
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetTarget(scard.tg)
  e1:SetOperation(scard.op)
  c:RegisterEffect(e1)
end

function scard.flag_op(e,tp,eg,ep,ev,re,r,rp)
  if re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetCode()==EVENT_FREE_CHAIN then
    local c=re:GetHandler()
    if c:GetOriginalCode()==s_id then return end
    if c:GetFlagEffect(s_id)~=0 then c:ResetFlagEffect(s_id) end
    c:RegisterFlagEffect(s_id,RESET_PHASE+PHASE_END,0,3)
    c:RegisterFlagEffect(s_id,RESET_PHASE+PHASE_END,0,1)
  end
end

function scard.rpl_fil(c,e,tp,eg,ep,ev,re,r,rp)
  if c:GetFlagEffect(s_id)==1 and not 
  scard['no_react_ev'] and c:IsCanBeEffectTarget(e) then
    local te=c:GetActivateEffect()
    if not te then return false end
    local cd=te:GetCondition()
    local cs=te:GetCost()
    local tg=te:GetTarget()
    return te:IsActivatable(tp) and
      (not cd or cd(te,tp,eg,ep,ev,re,r,rp)) and
      (not cs or cs(te,tp,eg,ep,ev,re,r,rp,0)) and
      (not tg or tg(te,tp,eg,ep,ev,re,r,rp,0))
  end
  return false
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk)
  local g=Duel.GetMatchingGroup(scard.rpl_fil,tp,LOCATION_GRAVE,0,nil,e,tp,eg,ep,ev,re,r,rp)
  if chk==0 then
    local loc
    if e:GetHandler():IsLocation(LOCATION_SZONE) then
      loc=Duel.GetLocationCount(tp,LOCATION_SZONE)>0
    else
      loc=Duel.GetLocationCount(tp,LOCATION_SZONE)>1
    end
    return loc and g:GetCount()>0
  end
  e:SetProperty(EFFECT_FLAG_CARD_TARGET)
  Duel.Hint(HINT_SELECTMSG,tp,550)
  local tc=g:Select(tp,1,1,nil)
  Duel.SetTargetCard(tc)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if not tc:IsRelateToEffect(e) or Duel.GetLocationCount(tp,LOCATION_SZONE)<1 then return end
  local te=tc:GetActivateEffect()
  local cd=te:GetCondition()
  local cs=te:GetCost()
  local tg=te:GetTarget()
  local op=te:GetOperation()
  if te:IsActivatable(tp) and
    (not cd or cd(te,tp,eg,ep,ev,re,r,rp)) and
    (not cs or cs(te,tp,eg,ep,ev,re,r,rp,0)) and
    (not tg or tg(te,tp,eg,ep,ev,re,r,rp,0))
  then
    Duel.ClearTargetCard()
    e:SetProperty(te:GetProperty())
    Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
    Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
    if not (tc:IsType(TYPE_SPELL) and tc:IsType(TYPE_CONTINUOUS+TYPE_EQUIP)) then tc:CancelToGrave(false) end
    if not tc:IsType(TYPE_SPELL) then return end
    tc:CreateEffectRelation(te)
    if cs then cs(te,tp,eg,ep,ev,re,r,rp,1) end
    if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
    local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
    if g then
      local tgc=g:GetFirst()
      while tgc do
        tgc:CreateEffectRelation(te)
        tgc=g:GetNext()
      end
    end
    tc:SetStatus(STATUS_ACTIVATED,true)
    if op then op(te,tp,eg,ep,ev,re,r,rp) end
    tc:ReleaseEffectRelation(te)
    if g then
      local tgc=g:GetFirst()
      while tgc do
        tgc:ReleaseEffectRelation(te)
        tgc=g:GetNext()
      end
    end
  end
end