--Odd-Eyes Raging Dragon (Anime)
function c511009340.initial_effect(c)
	c:EnableReviveLimit()
	aux.EnablePendulumAttribute(c,false)
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),7,2)
	--pendulum set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(7548,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511009340.pctg)
	e1:SetOperation(c511009340.pcop)
	c:RegisterEffect(e1)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c511009340.regcon)
	e2:SetOperation(c511009340.regop)
	c:RegisterEffect(e2)
	--material check
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_MATERIAL_CHECK)
	e3:SetValue(c511009340.valcheck)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--pendulum
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(7548,0))
	e7:SetCategory(CATEGORY_DESTROY)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e7:SetCode(EVENT_DESTROYED)
	e7:SetProperty(EFFECT_FLAG_DELAY)
	e7:SetCondition(c511009340.pencon)
	e7:SetTarget(c511009340.pentg)
	e7:SetOperation(c511009340.penop)
	c:RegisterEffect(e7)
end
function c511009340.pcfilter(c)
	return c:IsType(TYPE_PENDULUM) and not c:IsForbidden()
end
function c511009340.pctg(e,tp,eg,ep,ev,re,r,rp,chk)
	local seq=e:GetHandler():GetSequence()
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,13-seq)
		and Duel.IsExistingMatchingCard(c511009340.pcfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c511009340.pcop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local seq=e:GetHandler():GetSequence()
	if not Duel.CheckLocation(tp,LOCATION_SZONE,13-seq) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c511009340.pcfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.MoveToField(g:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end


function c511009340.regcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_XYZ)==SUMMON_TYPE_XYZ and e:GetLabel()==1
end
function c511009340.regop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
	--extra att
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(7548,1))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c511009340.descost)
	e2:SetTarget(c511009340.destg)
	e2:SetOperation(c511009340.desop)
	e2:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e2)
end
function c511009340.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	Duel.SendtoGrave(e:GetHandler():GetOverlayGroup(),REASON_COST)
end
function c511009340.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.IsExistingMatchingCard(c511009340.negfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
	if chk==0 then return g end
	local g2=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g2,g2:GetCount(),0,0)
end
function c511009340.negfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsFaceup() 
end
function c511009340.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511009340.negfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	if not tc then return end
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		if tc:IsType(TYPE_TRAPMONSTER) then
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e3)
		end
		tc=g:GetNext()
	end
		Duel.BreakEffect()
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct>0 and c:IsFaceup() and c:IsRelateToEffect(e) then
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_UPDATE_ATTACK)
		e4:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		e4:SetValue(ct*200)
		c:RegisterEffect(e4)
	end
end
function c511009340.matfilter(c)
	return c:IsType(TYPE_XYZ) and c:IsHasEffect(EFFECT_XYZ_LEVEL) and c:IsXyzLevel(c,7)
end
function c511009340.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(c511009340.matfilter,1,nil) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end


function c511009340.pencon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0 and e:GetHandler():IsPreviousLocation(LOCATION_MZONE)
end
function c511009340.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) end
end
function c511009340.penop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(tp,LOCATION_SZONE,6) and not Duel.CheckLocation(tp,LOCATION_SZONE,7) then return false end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end
