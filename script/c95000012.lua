--Toon World
function c95000012.initial_effect(c)
    --activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetValue(c95000012.valcon)
	c:RegisterEffect(e2)
end
c95000012.mark=0
function c95000012.valcon(e,re,r,rp)
    return bit.band(r,REASON_EFFECT)~=0
end
