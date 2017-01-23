--Sacred Revelation
function c511002329.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002329.condition)
	e1:SetCost(c511002329.cost)
	e1:SetOperation(c511002329.activate)
	c:RegisterEffect(e1)
end
function c511002329.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c511002329.costfilter(c)
	return c:IsRace(RACE_FAIRY) and c:IsLevelBelow(4)
end
function c511002329.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002329.costfilter,tp,LOCATION_DECK,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511002329.costfilter,tp,LOCATION_DECK,0,2,2,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511002329.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetAttackTarget()==nil then
		Duel.NegateAttack()
	end
end
