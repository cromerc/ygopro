--Fusion Front Base
function c511002016.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002016.condition)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_DAMAGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetValue(c511002016.damval)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c511002016.sdcon)
	c:RegisterEffect(e3)
end
function c511002016.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION)
end
function c511002016.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511002016.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511002016.damval(e,re,val,r,rp,rc)
	if re and bit.band(r,REASON_EFFECT)~=0 then return 0
	else return val end
end
function c511002016.sdcon(e)
	return not Duel.IsExistingMatchingCard(c511002016.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
