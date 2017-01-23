--Double Check
function c511000983.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c511000983.condition)
	e1:SetTarget(c511000983.target)
	e1:SetOperation(c511000983.activate)
	c:RegisterEffect(e1)
end
function c511000983.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	if not at then return false end
	if at:IsControler(tp) then at=Duel.GetAttacker() end
	return at and at:IsRelateToBattle() and not at:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c511000983.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local at=Duel.GetAttackTarget()
	if at:IsControler(tp) then at=Duel.GetAttacker() end
	if chk==0 then return at:IsDestructable() end
	Duel.SetTargetCard(at)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,at,1,0,0)
end
function c511000983.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToBattle() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
