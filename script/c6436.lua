--Scripted by Eerie Code
--PSYFrame Circuit
function c6436.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Synchro Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(6436,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c6436.syncon)
	e2:SetTarget(c6436.syntg)
	e2:SetOperation(c6436.synop)
	c:RegisterEffect(e2)
	--ATK Change
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(6436,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_START)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c6436.atkcon)
	e3:SetCost(c6436.atkcost)
	e3:SetOperation(c6436.atkop)
	c:RegisterEffect(e3)
end

function c6436.sumfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0xd3) and c:IsControler(tp)
end
function c6436.syncon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c6436.sumfilter,1,nil,tp)
end
function c6436.mfilter(c)
	return c:IsSetCard(0xd3)
end
function c6436.syntg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg=Duel.GetMatchingGroup(c6436.mfilter,tp,LOCATION_MZONE,0,nil)
		return Duel.IsExistingMatchingCard(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,1,nil,nil,mg)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c6436.synop(e,tp,eg,ep,ev,re,r,rp)
	local mg=Duel.GetMatchingGroup(c6436.mfilter,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,nil,nil,mg)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SynchroSummon(tp,sg:GetFirst(),nil,mg)
	end
end

function c6436.atkcon(e,tp,eg,ep,ev,re,r,rp)
	--local tc=Duel.GetAttacker()
	--local bc=Duel.GetAttackTarget()
	--if not bc then return false end
	--if tc:IsControler(1-tp) then
--  e:SetLabelObject(bc)
--  return bc:IsFaceup() and bc:IsSetCard(0xd3)
--  else
--  e:SetLabelObject(tc)
--  return tc:IsFaceup() and tc:IsSetCard(0xd3)
--  end
	local c=Duel.GetAttackTarget()
	if not c then return false end
	if c:IsControler(1-tp) then c=Duel.GetAttacker() end
	e:SetLabelObject(c)
	return c and c:IsSetCard(0xd3) and c:IsRelateToBattle()
end
function c6436.cfilter(c)
	return c:IsSetCard(0xd3) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c6436.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.IsExistingMatchingCard(c6436.cfilter,tp,LOCATION_HAND,0,1,nil) end
  local dg=Duel.SelectMatchingCard(tp,c6436.cfilter,tp,LOCATION_HAND,0,1,1,nil)
  e:SetLabel(dg:GetFirst():GetAttack())
  Duel.SendtoGrave(dg,REASON_COST+REASON_DISCARD)
end
--function c6436.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
--	if chk==0 then return Duel.IsExistingMatchingCard(c6436.cfilter,tp,LOCATION_HAND,0,1,nil) end
--end
function c6436.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	if c:IsFacedown() or not tc:IsFaceup() or not c:IsRelateToEffect(e)then return end
	--local dg=Duel.SelectMatchingCard(tp,c6436.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	--local dc=Duel.SendtoGrave(dg,REASON_COST+REASON_DISCARD)
	--dg:KeepAlive()
	local atk=e:GetLabel()
	if atk and atk>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+RESET_END)
		tc:RegisterEffect(e1)
	end
end