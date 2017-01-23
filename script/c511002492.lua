--Back Attack Ambush
function c511002492.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002492.condition)
	e1:SetTarget(c511002492.target)
	e1:SetOperation(c511002492.activate)
	c:RegisterEffect(e1)
end
function c511002492.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c511002492.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(Card.IsPosition,tp,0,LOCATION_MZONE,nil,POS_FACEUP_ATTACK)
	if chk==0 then return ct>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>=ct 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511002493,0,0x4011,100,100,1,RACE_WARRIOR,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,ct,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ct,0,0)
end
function c511002492.filter(c)
	return c:IsReleasableByEffect() and c:IsCode(511002493)
end
function c511002492.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(Card.IsPosition,tp,0,LOCATION_MZONE,nil,POS_FACEUP_ATTACK)
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if ft>ct then ft=ct end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,511002493,0,0x4011,100,100,1,RACE_WARRIOR,ATTRIBUTE_EARTH) then return end
	for i=1,ft do
		local token=Duel.CreateToken(tp,511002493)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
	local g=Duel.GetMatchingGroup(c511002492.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(63014935,2)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local sg=g:Select(tp,1,5,nil)
		Duel.Release(sg,REASON_EFFECT)
		Duel.Damage(1-tp,sg:GetCount()*500,REASON_EFFECT)
	end
end
