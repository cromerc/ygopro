--Burgundy the Magic Elf
function c511000826.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetOperation(c511000826.damop)
	c:RegisterEffect(e1)
end
function c511000826.filter(c)
	return c:IsReason(REASON_DISCARD)
end
function c511000826.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(c511000826.filter,nil)
	Duel.Damage(1-tp,ct*400,REASON_EFFECT)
end
