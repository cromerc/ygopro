--Frightfur Sanctuary
function c511002652.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511002652.cost)
	c:RegisterEffect(e1)
	--Effect Draw
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_ADD_SETCODE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_FUSION))
	e2:SetValue(0xad)
	c:RegisterEffect(e2)
end
function c511002652.cfilter(c)
	return c:IsSetCard(0xad) and c:IsAbleToGraveAsCost()
end
function c511002652.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,e:GetHandler()) 
		and Duel.IsExistingMatchingCard(c511002652.filter,tp,LOCATION_EXTRA,0,2,nil) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(tp,c511002652.cfilter,tp,LOCATION_EXTRA,0,2,2,nil)
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_COST)
end
