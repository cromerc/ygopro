--Zero Gazer
function c511001586.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001586.condition)
	e1:SetTarget(c511001586.target)
	e1:SetOperation(c511001586.activate)
	c:RegisterEffect(e1)
end
function c511001586.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c511001586.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttackTarget()
	if chk==0 then return tg and tg:IsOnField() and tg:GetAttack()>0 and tg:IsFaceup() and Duel.IsPlayerCanDraw(tp,1) end
end
function c511001586.activate(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d and d:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetReset(RESET_EVENT+0xfe0000)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		d:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_BATTLED)
		e2:SetOperation(c511001586.drop)
		e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
		Duel.RegisterEffect(e2,tp)
	end
end
function c511001586.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
end
