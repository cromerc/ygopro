--Battle x 2
function c511002619.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(82593786,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511002619.condition)
	e1:SetOperation(c511002619.activate)
	c:RegisterEffect(e1)
end
function c511002619.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return (Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()) and a and a:IsControler(tp) 
		and d and a:GetAttack()*2<=d:GetAttack()
end
function c511002619.filter(c,tp)
	return c:IsRelateToBattle() and c:IsControler(tp)
end
function c511002619.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.FromCards(Duel.GetAttacker(),Duel.GetAttackTarget())
	g=g:Filter(c511002619.filter,nil,tp)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(tc:GetAttack()*2)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
