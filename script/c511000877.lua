--Tuner's Explosion
function c511000877.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000877.cost)
	e1:SetTarget(c511000877.target)
	e1:SetOperation(c511000877.activate)
	c:RegisterEffect(e1)
end
function c511000877.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsType,ct,nil,TYPE_TUNER) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsType,ct,ct,nil,TYPE_TUNER)
	Duel.Release(g,REASON_COST)
end
function c511000877.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c511000877.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.Destroy(sg,REASON_EFFECT)
	if ct>0 then
		Duel.Damage(1-tp,ct*1000,REASON_EFFECT)
	end
end
