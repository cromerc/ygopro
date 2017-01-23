--Lady Bettle
function c511002339.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c511002339.valcon)
	c:RegisterEffect(e1)
end
function c511002339.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
