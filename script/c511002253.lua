--Mechanic's Soul
function c511002253.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCost(c511002253.cost)
	e1:SetTarget(c511002253.target)
	e1:SetOperation(c511002253.activate)
	c:RegisterEffect(e1)
end
function c511002253.cfilter(c)
	return c:IsSetCard(0x16) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c511002253.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002253.cfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511002253.cfilter,tp,LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511002253.filter(c,tp)
	return c:IsSetCard(0x16) and c:GetPreviousControler()==tp and c:IsControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
end
function c511002253.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c511002253.filter,nil,tp)
	local tc=g:GetFirst()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and g:GetCount()==1 end
	Duel.SetTargetCard(tc)
end
function c511002253.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,tc:GetPreviousPosition(),true)
	end
end
