--Flame Wall
function c511000131.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--avoid effect damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetCondition(c511000131.condition)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c511000131.damval)
	c:RegisterEffect(e1)
end
function c511000131.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsRace,tp,LOCATION_GRAVE,0,1,nil,RACE_PYRO)
end
function c511000131.damval(e,re,val,r,rp,rc)
	if rp~=e:GetHandlerPlayer() and bit.band(r,REASON_EFFECT)~=0 then return 0
	else return val end
end