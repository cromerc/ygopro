--Electric Shock
function c511002338.initial_effect(c)
	--disable attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002338.condition)
	e1:SetTarget(c511002338.target)
	e1:SetOperation(c511002338.activate)
	c:RegisterEffect(e1)
end
function c511002338.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE)
end
function c511002338.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.IsExistingMatchingCard(c511002338.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511002338.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(Duel.GetAttacker())
end
function c511002338.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() and Duel.NegateAttack() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-500)
		tc:RegisterEffect(e1)
	end
end
