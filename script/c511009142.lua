--White Morray
function c511009142.initial_effect(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c511009142.sumsuc)
	c:RegisterEffect(e1)
	
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	e2:SetCondition(c511009142.condition)
	c:RegisterEffect(e2)
	
	--spsum success
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(c511009142.gete)
	c:RegisterEffect(e1)
end
function c511009142.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(95100847,RESET_EVENT+0x1ec0000,0,1)
end
function c511009142.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(95100847)>0
end
function c511009142.gete(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetPreviousLocation()~=LOCATION_GRAVE then return end
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_ADD_TYPE)
	e1:SetValue(TYPE_TUNER)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
end
