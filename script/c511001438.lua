--Guard Master
function c511001438.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c511001438.condition)
	e1:SetCost(c511001438.cost)
	e1:SetTarget(c511001438.target)
	e1:SetOperation(c511001438.operation)
	c:RegisterEffect(e1)
end
function c511001438.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and tc:IsPosition(POS_FACEUP_ATTACK)
end
function c511001438.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c511001438.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,Duel.GetAttackTarget(),1,0,0)
end
function c511001438.operation(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	Duel.ChangePosition(at,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,0,0)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	at:RegisterEffect(e1)
end
