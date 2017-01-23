--Obedience
function c511001500.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511001500.activate)
	c:RegisterEffect(e1)
end
function c511001500.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511001500.con)
	e1:SetOperation(c511001500.op)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511001500.cfilter(c,atk)
	return c:IsFaceup() and c:GetAttack()>atk
end
function c511001500.con(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	return at:IsDefensePos() and not Duel.IsExistingMatchingCard(c511001500.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,a:GetAttack())
end
function c511001500.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511001500)
	local at=Duel.GetAttackTarget()
	Duel.ChangePosition(at,POS_FACEUP_ATTACK)
end
