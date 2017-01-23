--Attack Guidance Armor
function c511001140.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001140.condition)
	e1:SetTarget(c511001140.target)
	e1:SetOperation(c511001140.activate)
	c:RegisterEffect(e1)
end
function c511001140.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511001140.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDefensePos,tp,LOCATION_MZONE,0,1,Duel.GetAttackTarget()) end
end
function c511001140.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local g=Duel.SelectMatchingCard(tp,Card.IsDefensePos,tp,LOCATION_MZONE,0,1,1,Duel.GetAttackTarget())
	local tc=g:GetFirst()
	if tc then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(600)
		tc:RegisterEffect(e1)
		if a:IsAttackable() and not a:IsImmuneToEffect(e) and not tc:IsImmuneToEffect(e) then 
			Duel.CalculateDamage(a,tc)
			Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
		end
	end
end
