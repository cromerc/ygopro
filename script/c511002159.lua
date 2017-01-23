--Anti the Sky
function c511002159.initial_effect(c)
	--pos
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511002159.condition)
	e1:SetCost(c511002159.cost)
	e1:SetTarget(c511002159.target)
	e1:SetOperation(c511002159.operation)
	c:RegisterEffect(e1)
end
function c511002159.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c511002159.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511002159.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttacker():IsDestructable() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,Duel.GetAttacker(),1,0,0)
end
function c511002159.operation(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	if at:IsAttackPos() and at:IsRelateToBattle() then
		Duel.Destroy(at,REASON_EFFECT)
	end
end
