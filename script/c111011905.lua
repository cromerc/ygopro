--NO10 エーテリック・ホルス
function c111011905.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,10,2)
	c:EnableReviveLimit()
	--addown
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(111011905,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c111011905.cost)
	e1:SetTarget(c111011905.target)
	e1:SetOperation(c111011905.operation)
	c:RegisterEffect(e1)
end
function c111011905.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c111011905.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)>Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0) end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_ONFIELD,nil)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)-Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,ct,0,0)
end
function c111011905.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_ONFIELD,nil)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)-Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)
	if ct>0 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DESTROY)
		local dg=g:Select(1-tp,ct,ct,nil)
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
