--Synchro Monument
function c511000039.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot disable summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE)
	e2:SetTarget(c511000039.target)
	c:RegisterEffect(e2)
	--summon success
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511000039.sumcon)
	e3:SetOperation(c511000039.sumsuc)
	c:RegisterEffect(e3)	
end
function c511000039.limfilter(c)
	return c:GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c511000039.target(e,c)
	return c:GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c511000039.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000039.limfilter,1,nil)
end
function c511000039.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(1,1)
	e1:SetValue(c511000039.elimit)
	e1:SetReset(RESET_EVENT+EVENT_ADJUST,2)
	c:RegisterEffect(e1)
end
function c511000039.elimit(e,re,tp)
	return re:GetHandler():IsType(TYPE_SPELL+TYPE_TRAP)
end
