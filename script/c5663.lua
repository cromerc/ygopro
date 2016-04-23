--覇王黒竜オッドアイズ・リベリオン・ドラゴン
function c5663.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),7,2)
	c:EnableReviveLimit()
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--pendulum set
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c5663.pcon1)
	e2:SetTarget(c5663.ptg1)
	e2:SetOperation(c5663.pop1)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c5663.descon)
	e3:SetTarget(c5663.destg)
	e3:SetOperation(c5663.desop)
	c:RegisterEffect(e3)
	--pendulum set
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCondition(c5663.pcon2)
	e4:SetTarget(c5663.ptg2)
	e4:SetOperation(c5663.pop2)
	c:RegisterEffect(e4)
end
c5663.pendulum_level=7
function c5663.pcon1(e,tp,eg,ep,ev,re,r,rp)
	local seq=e:GetHandler():GetSequence()
	return Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)==nil
end
function c5663.pfilter(c)
	return c:IsType(TYPE_PENDULUM) and not c:IsForbidden()
end
function c5663.ptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c5663.pfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c5663.pop1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local seq=e:GetHandler():GetSequence()
	if Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)~=nil then return end
	local g=Duel.SelectMatchingCard(tp,c5663.pfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		local scale=0
		if 13-seq==6 then scale=tc:GetLeftScale()
		else scale=tc:GetRightScale() end
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		tc:RegisterFlagEffect(5687,RESET_EVENT+0x1fe0000,0,1,scale)
	end
end
function c5663.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetSummonType()==SUMMON_TYPE_XYZ and c:GetMaterial():IsExists(Card.IsType,1,nil,TYPE_XYZ)
end
function c5663.dfilter(c)
	return c:IsFaceup() and c:IsLevelBelow(7) and c:IsDestructable()
end
function c5663.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c5663.dfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c5663.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c5663.dfilter,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct>0 and Duel.Damage(1-tp,ct*1000,REASON_EFFECT)~=0 then
		local c=e:GetHandler()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c5663.pcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsPreviousLocation(LOCATION_MZONE)
end
function c5663.pdfilter(c)
	return (c:GetSequence()==6 or c:GetSequence()==7) and c:IsDestructable()
end
function c5663.ptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c5663.pdfilter,tp,LOCATION_SZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c5663.pdfilter,tp,LOCATION_SZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c5663.pop2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c5663.pdfilter,tp,LOCATION_SZONE,0,nil)
	if Duel.Destroy(g,REASON_EFFECT)==0 then return end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
end
