--Battleguard #4
function c511001294.initial_effect(c)
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001294,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511001294.condition)
	e1:SetCost(c511001294.cost)
	e1:SetOperation(c511001294.operation)
	c:RegisterEffect(e1)
end
function c511001294.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp) and d:IsFaceup() and (d:IsSetCard(0x2310) or d:IsCode(39389320) or d:IsCode(40453765) or d:IsCode(20394040))
end
function c511001294.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(511001294)==0 end
	e:GetHandler():RegisterFlagEffect(511001294,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1)
end
function c511001294.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
