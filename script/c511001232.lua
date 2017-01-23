--Singularity Fiend
function c511001232.initial_effect(c)
	--disable spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e2:SetDescription(aux.Stringid(511001232,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_SPSUMMON)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c511001232.condition)
	e2:SetCost(c511001232.cost)
	e2:SetTarget(c511001232.target)
	e2:SetOperation(c511001232.operation)
	c:RegisterEffect(e2)
end
function c511001232.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=ep and Duel.GetCurrentChain()==0
end
function c511001232.costfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToGraveAsCost()
end
function c511001232.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and
		Duel.IsExistingMatchingCard(c511001232.costfilter,tp,LOCATION_HAND,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511001232.costfilter,tp,LOCATION_HAND,0,1,1,c)
	g:AddCard(c)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511001232.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
end
function c511001232.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.NegateSummon(eg:GetFirst())
	Duel.Destroy(eg,REASON_EFFECT)
end
