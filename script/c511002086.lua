--Hurricane Nest
function c511002086.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetDescription(aux.Stringid(41307269,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511002086.condition)
	e2:SetCost(c511002086.cost)
	e2:SetTarget(c511002086.target)
	e2:SetOperation(c511002086.operation)
	c:RegisterEffect(e2)
end
function c511002086.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if eg:GetCount()==1 and tc:GetSummonPlayer()~=tp then
		e:SetLabelObject(tc)
		return true
	else
		return false
	end
end
function c511002086.cfilter(c)
	return c:IsCode(42598242) and c:IsAbleToGraveAsCost()
end
function c511002086.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002086.cfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil )end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511002086.cfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511002086.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return tc and tc:IsDestructable() end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c511002086.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
