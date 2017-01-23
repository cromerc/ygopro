--Void Cauldron
function c511002201.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c511002201.reptg)
	e2:SetValue(c511002201.repval)
	c:RegisterEffect(e2)
end
function c511002201.repfilter(c)
	return c:IsOnField() and c:IsReason(REASON_EFFECT)
end
function c511002201.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0 
		and eg:IsExists(c511002201.repfilter,1,nil) end
	return Duel.SelectYesNo(tp,aux.Stringid(511002201,0))
end
function c511002201.repval(e,c)
	return c:IsOnField() and c:IsReason(REASON_EFFECT)
end
