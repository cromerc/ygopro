--Route Change
function c511001636.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001636.condition)
	e1:SetTarget(c511001636.target)
	e1:SetOperation(c511001636.activate)
	c:RegisterEffect(e1)
end
function c511001636.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511001636.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_MZONE,0,1,Duel.GetAttackTarget()) end
end
function c511001636.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_MZONE,0,1,1,Duel.GetAttackTarget())
	if g:GetCount()>0 then
		local a=Duel.GetAttacker()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(a:GetAttack()/2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL)
		a:RegisterEffect(e1)
		Duel.HintSelection(g)
		Duel.ChangeAttackTarget(g:GetFirst())
	end
end
