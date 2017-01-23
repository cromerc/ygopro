--Gem Fortress
function c511000288.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000288.condition)
	e1:SetOperation(c511000288.activate)
	c:RegisterEffect(e1)
end
function c511000288.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1034)
end
function c511000288.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000288.cfilter,tp,LOCATION_ONFIELD,0,4,nil)
end
function c511000288.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
