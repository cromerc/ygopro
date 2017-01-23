--Released Curse
function c511001472.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c511001472.condition)
	e1:SetTarget(c511001472.target)
	e1:SetOperation(c511001472.activate)
	c:RegisterEffect(e1)
end
function c511001472.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsCode,1,nil,511001466)
end
function c511001472.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c511001472.filter(c,tp)
	return c:GetOwner()==tp
end
function c511001472.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	if Duel.Destroy(g,REASON_EFFECT)>0 then
		local dg=Duel.GetOperatedGroup()
		local dam1=dg:FilterCount(c511001472.filter,nil,tp)
		local dam2=dg:FilterCount(c511001472.filter,nil,1-tp)
		Duel.Damage(tp,dam1*300,REASON_EFFECT)
		Duel.Damage(1-tp,dam2*300,REASON_EFFECT)
	end
end
