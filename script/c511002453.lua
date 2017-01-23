--Dazzling Radiance
function c511002453.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002453.condition)
	e1:SetOperation(c511002453.activate)
	c:RegisterEffect(e1)
end
function c511002453.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.IsExistingMatchingCard(Card.IsAttackPos,tp,0,LOCATION_MZONE,2,nil)
end
function c511002453.activate(e,tp,eg,ep,ev,re,r,rp)
	local cg=Duel.GetMatchingGroup(nil,tp,0,LOCATION_MZONE,nil)
	if cg:GetCount()<1 then return end
	Duel.NegateAttack()
	local g=Duel.GetMatchingGroup(Card.IsPosition,tp,0,LOCATION_MZONE,nil,POS_FACEUP_ATTACK)
	if g:GetCount()<=0 then return end
	local ag=g:GetMinGroup(Card.GetAttack)
	local a=ag:Select(1-tp,1,1,nil):GetFirst()
	local d=cg:Select(1-tp,1,1,a):GetFirst()
	Duel.CalculateDamage(a,d)
end
