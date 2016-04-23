--Rainbow Dark Dragon
function c79856794.initial_effect(c)
	c:EnableReviveLimit()
	c:SetUniqueOnField(1,1,79856794)
	--Rainbow Summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c79856794.rainbowcon)
	c:RegisterEffect(e1)
	--Cannot be Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e2)
	--Treated as "Rainbow Dragon"
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CHANGE_CODE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(79856792)
	c:RegisterEffect(e3)
	--Rainbow Dark Overdrive
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetDescription(aux.Stringid(79856794,0))
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetHintTiming(TIMING_DAMAGE_STEP)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c79856794.overdrivecon)
	e4:SetCost(c79856794.overdrivecost)
	e4:SetOperation(c79856794.overdriveop)
	c:RegisterEffect(e4)
	--Crystal Protection
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e5:SetDescription(aux.Stringid(79856794,1))
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_DESTROY_REPLACE)
	e5:SetCondition(c79856794.protectioncon)
	e5:SetTarget(c79856794.protectiontg)
	e5:SetOperation(c79856794.protectionop)
	c:RegisterEffect(e5)
	--Activation Limited
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetCode(EVENT_SPSUMMON_SUCCESS)
	e6:SetOperation(c79856794.limited)
	c:RegisterEffect(e6)
end
function c79856794.rainbowfilter(c)
	return c:IsSetCard(0x34) and (not c:IsOnField() or c:IsFaceup())
end
function c79856794.rainbowcon(e,c)
	if c==nil then return true end
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)<=0 then return false end
	local g=Duel.GetMatchingGroup(c79856794.rainbowfilter,c:GetControler(),LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	local ct=g:GetClassCount(Card.GetCode)
	return ct>6
end
function c79856794.overdrivecon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(79856794)~=0 then return false end
	local phase=Duel.GetCurrentPhase()
	return phase~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c79856794.overdrivefilter(c)
	return c:IsFaceup() and c:IsSetCard(0x34) and c:IsAbleToGraveAsCost()
end
function c79856794.overdrivecost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c79856794.overdrivefilter,tp,LOCATION_MZONE+LOCATION_SZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c79856794.overdrivefilter,tp,LOCATION_MZONE+LOCATION_SZONE,0,nil)
	Duel.SendtoGrave(g,REASON_COST)
	e:SetLabel(g:GetCount())
end
function c79856794.overdriveop(e,tp,eg,ep,ev,re,r,rp)
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
function c79856794.protectioncon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(79856794)==0
end
function c79856794.protectionfilter(c)
	return c:IsSetCard(0x34) and c:IsAbleToGraveAsCost()
end
function c79856794.protectiontg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c79856794.protectionfilter,tp,LOCATION_SZONE,0,1,nil) end
	return Duel.SelectYesNo(tp,aux.Stringid(79856794,1))
end
function c79856794.protectionop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c79856794.protectionfilter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_EFFECT)
end
function c79856794.limited(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(79856794,RESET_EVENT+0xfc0000+RESET_PHASE+PHASE_END,0,1)
end