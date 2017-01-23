--Iron Knight
--Jackpro 1.3
function c511001415.initial_effect(c)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetCondition(c511001415.sdcon)
	e2:SetValue(-1000)
	c:RegisterEffect(e2)
end
function c511001415.filter(c)
	return c:IsFaceup() and c:IsCode(511001416)
end
function c511001415.sdcon(e)
	return Duel.IsExistingMatchingCard(c511001415.filter,e:GetHandlerPlayer(),LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
