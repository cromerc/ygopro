--終焉の指名者
function c805000080.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c805000080.condition)
	e1:SetCost(c805000080.cost)
	e1:SetOperation(c805000080.activate)
	c:RegisterEffect(e1)
end
function c805000080.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c805000080.cfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsDiscardable()
end
function c805000080.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c805000080.cfilter,tp,LOCATION_HAND,0,1,nil) end
	local g=Duel.DiscardHand(tp,c805000080.cfilter,1,1,REASON_COST+REASON_DISCARD,nil):GetFirst()
	e:SetLabel(g:GetCode())
end
function c805000080.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabel()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,1)
	e1:SetValue(c805000080.aclimit)
	e1:SetLabel(g)
	Duel.RegisterEffect(e1,tp)
end
function c805000080.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsCode(e:GetLabel())
end
