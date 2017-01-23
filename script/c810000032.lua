-- Depth Eruption
-- scripted by: UnknownGuest
function c810000032.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c810000032.condition)
	e1:SetTarget(c810000032.target)
	e1:SetOperation(c810000032.activate)
	c:RegisterEffect(e1)
end
function c810000032.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsAttribute(ATTRIBUTE_WATER)
end
function c810000032.condition(e,c)
	local tp=e:GetHandler():GetControler()
	if c==nil then return true end
	return Duel.IsExistingMatchingCard(c810000032.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c810000032.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c810000032.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.Destroy(sg,REASON_EFFECT)
end
