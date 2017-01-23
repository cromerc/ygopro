--Xyz Pieces
function c511002122.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511002122.condition)
	e1:SetTarget(c511002122.target)
	e1:SetOperation(c511002122.activate)
	c:RegisterEffect(e1)
end
function c511002122.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at and at:IsFaceup() and at:IsControler(tp) and at:IsType(TYPE_XYZ)
end
function c511002122.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(Duel.GetAttackTarget())
end
function c511002122.filter(c,e,tp)
	return c:GetLevel()==1 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002122.activate(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	if not Duel.NegateAttack() then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetMatchingGroup(c511002122.filter,tp,LOCATION_DECK,0,nil,e,tp)
	if at and at:IsRelateToEffect(e) and at:IsReleasableByEffect() and g:GetCount()>1 
		and Duel.SelectYesNo(tp,aux.Stringid(63014935,2)) then
		if Duel.Release(at,REASON_EFFECT)~=0 then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=g:Select(tp,2,2,nil)
			local tc=sg:GetFirst()
			while tc do
				Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK)
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_DISABLE)
				e1:SetReset(RESET_EVENT+0x1fe0000)
				tc:RegisterEffect(e1,true)
				local e2=Effect.CreateEffect(e:GetHandler())
				e2:SetType(EFFECT_TYPE_SINGLE)
				e2:SetCode(EFFECT_DISABLE_EFFECT)
				e2:SetReset(RESET_EVENT+0x1fe0000)
				tc:RegisterEffect(e2,true)
				tc=sg:GetNext()
			end
			Duel.SpecialSummonComplete()
		end
	end
end
