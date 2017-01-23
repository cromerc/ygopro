--Hell Vermin Mine
function c511002646.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002646.target)
	e1:SetOperation(c511002646.activate)
	c:RegisterEffect(e1)
end
function c511002646.filter(c)
	return (c:IsCode(36029076) or c:IsSetCard(0x21b)) and c:IsAbleToGrave()
end
function c511002646.desfilter(c)
	return c:IsAttackPos() and c:IsDestructable()
end
function c511002646.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002646.filter,tp,LOCATION_HAND,0,1,nil) 
		and Duel.IsExistingMatchingCard(c511002646.desfilter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c511002646.desfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511002646.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c511002646.filter,tp,LOCATION_HAND,0,1,1,nil)
	if g1:GetCount()>0 then
		Duel.SendtoGrave(g1,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectMatchingCard(tp,c511002646.desfilter,tp,0,LOCATION_MZONE,1,1,nil)
	if g2:GetCount()>0 then
		Duel.HintSelection(g2)
		Duel.Destroy(g2,REASON_EFFECT)
	end
end