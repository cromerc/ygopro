--Xyz Discharge
function c511001490.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001490.cost)
	e1:SetTarget(c511001490.target)
	e1:SetOperation(c511001490.activate)
	c:RegisterEffect(e1)
end
function c511001490.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,1-tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(1-tp,Card.IsAbleToGraveAsCost,1-tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511001490.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsControlerCanBeChanged()
end
function c511001490.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511001490.filter,1-tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,1,tp,LOCATION_MZONE)
end
function c511001490.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectMatchingCard(1-tp,c511001490.filter,1-tp,0,LOCATION_MZONE,ft,ft,nil)
	local tc=g:GetFirst()
	while tc do
		Duel.GetControl(tc,1-tp)
		tc=g:GetNext()
	end
end
