--Amazoness Trainer
function c511001907.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c511001907.condition)
	e1:SetTarget(c511001907.target)
	e1:SetOperation(c511001907.activate)
	c:RegisterEffect(e1)
end
function c511001907.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	if d:IsControler(tp) or a:IsControler(1-tp) then return false end
	return a:IsCode(10979723) and a:IsRelateToBattle() and d:IsLocation(LOCATION_ONFIELD)
end
function c511001907.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	if chk==0 then return a:IsChainAttackable() end
end
function c511001907.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if a and a:IsRelateToBattle() and a:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(400)
		a:RegisterEffect(e1)
		Duel.ChainAttack()
	end
end
