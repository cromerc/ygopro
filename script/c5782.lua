--ルーレット・スパイダー
function c5782.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c5782.condition)
	e1:SetOperation(c5782.activate)
	c:RegisterEffect(e1)
end
function c5782.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c5782.activate(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	local dc=Duel.TossDice(tp,1)
	if dc==1 then
		Duel.SetLP(tp,Duel.GetLP(tp)/2)
	end
	if dc==2 and at:IsAttackable() and not at:IsStatus(STATUS_ATTACK_CANCELED) then
		Duel.ChangeAttackTarget(nil)
	end
	if dc==3 then
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_MZONE,0,1,1,Duel.GetAttackTarget())
		if g:GetCount()>0 then
			Duel.CalculateDamage(at,g:GetFirst())
		end
	end
	if dc==4 then
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,at)
		if g:GetCount()>0 then
			Duel.CalculateDamage(at,g:GetFirst())
		end
	end
	if dc==5 and Duel.NegateAttack() then
		Duel.Damage(1-tp,at:GetAttack(),REASON_EFFECT)
	end
	if dc==6 then
		Duel.Destroy(at,REASON_EFFECT)
	end
end
