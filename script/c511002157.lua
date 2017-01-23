--Anti the Abyss
function c511002157.initial_effect(c)
	-- Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511002157,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511002157.condition)
	e1:SetCost(c511002157.cost)
	e1:SetTarget(c511002157.target)
	e1:SetOperation(c511002157.operation)
	c:RegisterEffect(e1)
end
function c511002157.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at and at:IsControler(tp)
end
function c511002157.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511002157.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local at=Duel.GetAttackTarget()
	if chk==0 then return true end
	Duel.SetTargetCard(at)
end
function c511002157.operation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() and a:IsRelateToBattle() and a:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(a:GetAttack())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e2:SetValue(1)
		e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e2)
	end
end
