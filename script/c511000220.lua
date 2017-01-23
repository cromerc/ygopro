--Chaos Barrier Field
function c511000220.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511000220.condition)
	e1:SetTarget(c511000220.target)
	e1:SetOperation(c511000220.activate)
	c:RegisterEffect(e1)
end
function c511000220.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.IsExistingMatchingCard(Card.IsPosition,tp,0,LOCATION_MZONE,2,nil,POS_FACEUP_ATTACK)
end
function c511000220.filter(c)
	return c:IsAttackPos()
end
function c511000220.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000220.filter,tp,0,LOCATION_MZONE,2,nil) end
end
function c511000220.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(Card.IsPosition,tp,0,LOCATION_MZONE,nil,POS_FACEUP_ATTACK)
	local g2=Duel.GetMatchingGroup(Card.IsPosition,tp,0,LOCATION_MZONE,nil,POS_FACEUP_ATTACK)
	if g1:GetCount()==0 or g2:GetCount()==0 then return end
	local ga=g1:GetMaxGroup(Card.GetAttack)
	local gd=g2:GetMinGroup(Card.GetAttack)
	if ga:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511000220,0))
		ga=ga:Select(tp,1,1,nil)
	end
	if gd:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511000220,1))
		gd=gd:Select(tp,1,1,nil)
	end
	Duel.NegateAttack()
	Duel.CalculateDamage(ga:GetFirst(),gd:GetFirst())
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
end
