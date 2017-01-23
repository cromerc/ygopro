--覇王黒竜オッドアイズ・リベリオン・ドラゴン
function c511001791.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),7,2)
	c:EnableReviveLimit()
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--pendulum set
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511001791.pctg)
	e1:SetOperation(c511001791.pcop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c511001791.descon)
	e2:SetTarget(c511001791.destg)
	e2:SetOperation(c511001791.desop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_MATERIAL_CHECK)
	e3:SetValue(c511001791.valcheck)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--multi atk
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511001791,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c511001791.atkcon)
	e4:SetCost(c511001791.atkcost)
	e4:SetTarget(c511001791.atktg)
	e4:SetOperation(c511001791.atkop)
	c:RegisterEffect(e4)
	--To Pendulum
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(35952884,1))
	e5:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetCondition(c511001791.pencon)
	e5:SetTarget(c511001791.pentg)
	e5:SetOperation(c511001791.penop)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EVENT_REMOVE)
	c:RegisterEffect(e6)
	local e7=e5:Clone()
	e7:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e7)
	if not c511001791.global_check then
		c511001791.global_check=true
		c511001791[0]=0
		c511001791[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DESTROYED)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetOperation(c511001791.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511001791.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511001791.pcfilter(c)
	return c:IsType(TYPE_PENDULUM) and not c:IsForbidden()
end
function c511001791.pctg(e,tp,eg,ep,ev,re,r,rp,chk)
	local seq=e:GetHandler():GetSequence()
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,13-seq)
		and Duel.IsExistingMatchingCard(c511001791.pcfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c511001791.pcop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local seq=e:GetHandler():GetSequence()
	if not Duel.CheckLocation(tp,LOCATION_SZONE,13-seq) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c511001791.pcfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.MoveToField(g:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end
function c511001791.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ and e:GetLabel()==1
end
function c511001791.desfilter(c)
	return c:IsFaceup() and c:IsLevelBelow(7) and c:IsDestructable()
end
function c511001791.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c511001791.desfilter,tp,0,LOCATION_MZONE,nil)
	local sum=g:GetSum(Card.GetAttack)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,sum)
end
function c511001791.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511001791.desfilter,tp,0,LOCATION_MZONE,nil)
	if Duel.Destroy(g,REASON_EFFECT)>0 then
		local dg=Duel.GetOperatedGroup()
		local sum=dg:GetSum(Card.GetPreviousAttackOnField)
		Duel.Damage(1-tp,sum,REASON_EFFECT)
	end
end
function c511001791.matfilter(c)
	return c:IsType(TYPE_XYZ) and c:IsHasEffect(EFFECT_XYZ_LEVEL) and c:IsXyzLevel(c,7)
end
function c511001791.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(c511001791.matfilter,1,nil) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end
function c511001791.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 and c511001791[tp]>0
end
function c511001791.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511001791.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetEffectCount(EFFECT_EXTRA_ATTACK)==0 end
end
function c511001791.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(c511001791[tp]-1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c511001791.pencon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c511001791.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	local lsc=Duel.GetFieldCard(tp,LOCATION_SZONE,6)
	local rsc=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
	local g=Group.FromCards(lsc,rsc):Filter(Card.IsDestructable,nil)
	if chk==0 then return g:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511001791.penop(e,tp,eg,ep,ev,re,r,rp)
	local lsc=Duel.GetFieldCard(tp,LOCATION_SZONE,6)
	local rsc=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
	local g=Group.FromCards(lsc,rsc)
	if Duel.Destroy(g,REASON_EFFECT)~=0 and e:GetHandler():IsRelateToEffect(e) then
		Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end
function c511001791.desfilter2(c,tp)
	return c:GetPreviousControler()==tp and bit.band(c:GetPreviousTypeOnField(),TYPE_MONSTER)==TYPE_MONSTER
end
function c511001791.checkop(e,tp,eg,ep,ev,re,r,rp)
	local ct1=eg:FilterCount(c511001791.desfilter2,nil,1-tp)
	local ct2=eg:FilterCount(c511001791.desfilter2,nil,tp)
	if ct1>0 then
		c511001791[tp]=c511001791[tp]+ct1
	end
	if ct2>0 then
		c511001791[1-tp]=c511001791[1-tp]+ct2
	end
end
function c511001791.clear(e,tp,eg,ep,ev,re,r,rp)
	c511001791[0]=0
	c511001791[1]=0
end
