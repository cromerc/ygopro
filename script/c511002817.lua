--Rival Crush
function c511002817.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetCondition(c511002817.condition)
	e1:SetOperation(c511002817.activate)
	c:RegisterEffect(e1)
end
function c511002817.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()<PHASE_MAIN2
end
function c511002817.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(c511002817.atktarget)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511002817.filter(c,atk)
	local atkct=c:GetEffectCount(EFFECT_EXTRA_ATTACK)+1
	return c:IsFaceup() and c:GetAttack()>atk and c:IsAttackable() and c:GetAttackedCount()<atkct
end
function c511002817.atktarget(e,c)
	local atk=c:GetAttack()
	local p=c:GetControler()
	return c:IsFaceup() and rk>0 and Duel.IsExistingMatchingCard(c511002817.filter,p,LOCATION_MZONE,0,1,nil,atk)
end
