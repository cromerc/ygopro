--Starve Venom Fusion Dragon (Anime)
function c511009025.initial_effect(c)
  --fusion
  c:EnableReviveLimit()
  -- aux.AddFusionProcFunRep(c,c511009025.mat_filter,2,true)
  if Card.IsFusionAttribute then
		aux.AddFusionProcFunRep(c,c511009025.mat_filter1,2,true)
	else
		aux.AddFusionProcFunRep(c,c511009025.mat_filter2,2,true)
	end
  --material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetDescription(aux.Stringid(511000674,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511009025.atkcon)
	e1:SetTarget(c511009025.tg)
	e1:SetOperation(c511009025.op)
	c:RegisterEffect(e1)
  --
  local e2=Effect.CreateEffect(c)
  e2:SetDescription(aux.Stringid(7338,1))
  e2:SetType(EFFECT_TYPE_IGNITION)
  e2:SetRange(LOCATION_MZONE)
  e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
  e2:SetCountLimit(1)
  e2:SetTarget(c511009025.nmtg)
  e2:SetOperation(c511009025.nmop)
  c:RegisterEffect(e2)
  --
  local e3=Effect.CreateEffect(c)
  e3:SetDescription(aux.Stringid(7338,2))
  e3:SetCategory(CATEGORY_DESTROY)
  e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
  e3:SetCode(EVENT_DESTROYED)
  e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
  e3:SetCondition(c511009025.descon)
  e3:SetTarget(c511009025.destg)
  e3:SetOperation(c511009025.desop)
  c:RegisterEffect(e3)
  if not c511009025.global_check then
		c511009025.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetLabel(511009025)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(aux.sumreg)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511009025.mat_filter1(c)
  return c:IsFusionAttribute(ATTRIBUTE_DARK)
end
function c511009025.mat_filter2(c)
  return c:IsAttribute(ATTRIBUTE_DARK)
end
function c511009025.atkfil(c)
  return not c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c511009025.atkcon(e,tp,eg,ep,ev,re,r,rp)
  local ph=Duel.GetCurrentPhase()
  local c=e:GetHandler()
	return c:GetFlagEffect(511009025)~=0 and bit.band(c:GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION and c:GetMaterial()
	  and not c:GetMaterial():IsExists(c511009025.atkfil,1,nil)
end
function c511009025.filter(c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c511009025.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009025.filter,tp,0,LOCATION_MZONE,1,nil) end
end
function c511009025.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511009025.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		local atk=0
		local tc=g:GetFirst()
		while tc do
			atk=atk+tc:GetAttack()
			tc=g:GetNext()
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end

function c511009025.nmfil(c)
  return c:IsFaceup() and c:IsLevelAbove(5)
end
function c511009025.nmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511009025.nmfil(chkc) end
  if chk==0 then return Duel.IsExistingTarget(c511009025.nmfil,tp,0,LOCATION_MZONE,1,nil) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
  Duel.SelectTarget(tp,c511009025.nmfil,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511009025.nmop(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  local tc=Duel.GetFirstTarget()
  if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsFaceup() then
	local code=tc:GetCode()
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DISABLE_EFFECT)
	e3:SetValue(RESET_TURN_SET)
	e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e3)
	c:CopyEffect(code,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,1)
  end
end

function c511009025.descon(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  return c:IsPreviousLocation(LOCATION_MZONE)
end
function c511009025.desfil(c)
  return c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c511009025.destg(e,tp,eg,ep,ev,re,r,rp,chk)
 if chk==0 then return Duel.IsExistingMatchingCard(c511009025.desfil,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c511009025.desfil,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c511009025.desop(e,tp,eg,ep,ev,re,r,rp)
 local g=Duel.GetMatchingGroup(c511009025.desfil,tp,0,LOCATION_MZONE,nil)
	if Duel.Destroy(g,REASON_EFFECT)>0 then
		local dg=Duel.GetOperatedGroup()
		local atk=0
		local tc=dg:GetFirst()
		while tc do
			if tc:IsPreviousPosition(POS_FACEUP) then
				atk=atk+tc:GetPreviousAttackOnField()
			end
			tc=dg:GetNext()
		end
		Duel.Damage(1-tp,atk,REASON_EFFECT)
	end
end
