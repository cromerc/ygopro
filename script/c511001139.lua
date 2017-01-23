--Rainbow Dark Dragon
function c511001139.initial_effect(c)
	c:EnableReviveLimit()
	--Rainbow Summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511001139.spcon)
	c:RegisterEffect(e1)
	--Cannot be Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e2)
	--Rainbow Dark Overdrive
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetDescription(aux.Stringid(511001139,0))
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetHintTiming(TIMING_DAMAGE_STEP)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c511001139.overdrivecon)
	e4:SetCost(c511001139.overdrivecost)
	e4:SetOperation(c511001139.overdriveop)
	c:RegisterEffect(e4)
	--Crystal Protection
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e5:SetDescription(aux.Stringid(511001139,1))
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_DESTROY_REPLACE)
	e5:SetCondition(c511001139.protectioncon)
	e5:SetTarget(c511001139.protectiontg)
	e5:SetOperation(c511001139.protectionop)
	c:RegisterEffect(e5)
	--banish self
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetProperty(EFFECT_FLAG_DELAY)
	e6:SetCode(EVENT_REMOVE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetOperation(c511001139.banop)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetCode(EVENT_ADJUST)
	e7:SetRange(LOCATION_MZONE)
	e7:SetOperation(c511001139.banop)
	c:RegisterEffect(e7)
	if not c511001139.global_check then
		c511001139.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetLabel(511001139)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(aux.sumreg)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge2:SetLabel(511001139)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511001139.rainbowfilter(c)
	return c:IsSetCard(0x5034) and (not c:IsOnField() or c:IsFaceup())
end
function c511001139.spcon(e,c)
	if c==nil then return true end
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)<=0 then return false end
	local g=Duel.GetMatchingGroup(c511001139.rainbowfilter,c:GetControler(),LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	local ct=g:GetClassCount(Card.GetCode)
	return ct>6
end
function c511001139.overdrivecon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(511001139)~=0 then return false end
	local phase=Duel.GetCurrentPhase()
	return phase~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511001139.overdrivefilter(c)
	return c:IsFaceup() and c:IsSetCard(0x5034) and c:IsAbleToGraveAsCost()
end
function c511001139.overdrivecost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001139.overdrivefilter,tp,LOCATION_ONFIELD,0,1,nil) end
	local g=Duel.GetMatchingGroup(c511001139.overdrivefilter,tp,LOCATION_ONFIELD,0,nil)
	Duel.SendtoGrave(g,REASON_COST)
	e:SetLabel(g:GetCount())
end
function c511001139.overdriveop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel()*1000)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
	end
end
function c511001139.protectioncon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(511001139)==0
end
function c511001139.protectionfilter(c)
	return c:IsSetCard(0x1034) and c:IsAbleToGraveAsCost()
end
function c511001139.protectiontg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001139.protectionfilter,tp,LOCATION_SZONE,0,1,nil) end
	return Duel.SelectYesNo(tp,aux.Stringid(511001139,1))
end
function c511001139.protectionop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c511001139.protectionfilter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_EFFECT)
end
function c511001139.banop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511001139.rainbowfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	local ct=g:GetClassCount(Card.GetCode)
	if ct<7 then
		Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
	end
end
