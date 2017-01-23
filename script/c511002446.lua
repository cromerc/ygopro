--アヌビスの裁き
function c511002446.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511002446.condition)
	e1:SetTarget(c511002446.target)
	e1:SetOperation(c511002446.activate)
	c:RegisterEffect(e1)
end
function c511002446.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and Duel.IsChainDisablable(ev)
end
function c511002446.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c511002446.filter(c,tp)
	return c:GetPreviousControler()==tp
end
function c511002446.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if Duel.Destroy(sg,REASON_EFFECT)>0 then
		local dg=Duel.GetOperatedGroup()
		local sg1=dg:Filter(c511002446.filter,nil,tp)
		local sg2=dg:Filter(c511002446.filter,nil,1-tp)
		local sum1=sg1:GetSum(Card.GetAttack)/2
		local sum2=sg2:GetSum(Card.GetAttack)/2
		Duel.Damage(tp,sum1,REASON_EFFECT,true)
		Duel.Damage(1-tp,sum2,REASON_EFFECT,true)
		Duel.RDComplete()
	end
end
