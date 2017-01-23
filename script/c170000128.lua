--Amber Crystal Circle
function c170000128.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c170000128.condition)
	e1:SetTarget(c170000128.target)
	e1:SetOperation(c170000128.activate)
	c:RegisterEffect(e1)
end
function c170000128.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsCode(69937550) and d:IsFaceup() and d:IsControler(tp)
end
function c170000128.filter(c)
	return c:IsSetCard(0x1034) and c:IsFaceup()
end
function c170000128.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=Duel.GetAttackTarget()
	if chk==0 then return Duel.IsExistingMatchingCard(c170000128.filter,tp,LOCATION_MZONE,0,1,tc) end
	Duel.SetTargetCard(tc)
end
function c170000128.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttackTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local atk=0
		local g=Duel.GetMatchingGroup(c170000128.filter,tp,LOCATION_MZONE,0,tc)
		local bc=g:GetFirst()
		while bc do
			atk=atk+bc:GetAttack()
			bc=g:GetNext()
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
