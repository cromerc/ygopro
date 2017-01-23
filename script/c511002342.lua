--Butterfly Fairy
function c511002342.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511002342.spcon)
	e1:SetOperation(c511002342.spop)
	c:RegisterEffect(e1)
end
function c511002342.spfilter(c)
	local code=c:GetCode()
	return code==511002341 or code==16366944 or code==511000521
end
function c511002342.spcon(e,c)
	if c==nil then return true end
	return Duel.CheckReleaseGroup(c:GetControler(),c511002342.spfilter,2,nil)
end
function c511002342.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(tp,c511002342.spfilter,2,2,nil)
	Duel.Release(g,REASON_COST)
end
