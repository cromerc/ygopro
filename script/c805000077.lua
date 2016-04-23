--蟲惑の落とし穴
function c805000077.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c805000077.condition)
	e1:SetTarget(c805000077.target)
	e1:SetOperation(c805000077.activate)
	c:RegisterEffect(e1)
end
function c805000077.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
	and re:GetHandler():GetTurnID()==Duel.GetTurnCount() 
	and bit.band(re:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)~=0 and re:GetHandler():IsDestructable()
end
function c805000077.dfilter(c)
	return c:GetTurnID()==Duel.GetTurnCount() and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)~=0 and c:IsDestructable()
end
function c805000077.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c805000077.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
