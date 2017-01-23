-- Alpha-Wave Emission
-- scripted by: UnknownGuest
function c800000012.initial_effect(c)
	-- activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	-- cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c800000012.adfilter)
	c:RegisterEffect(e2)
	-- loses 300 ATK
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c800000012.adfilter)
	e3:SetValue(-300)
	c:RegisterEffect(e3)
end

function c800000012.adfilter(e,c)
	return c:IsPosition(POS_FACEUP_ATTACK)
end
