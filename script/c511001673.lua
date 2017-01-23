--Footsteps of the Goddess
function c511001673.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001673.target)
	e1:SetOperation(c511001673.operation)
	c:RegisterEffect(e1)
end
function c511001673.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanSpecialSummon(1-tp) 
		and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_HAND)
end
function c511001673.filter(c,e,tp)
	return c:IsAttackBelow(1500) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001673.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanSpecialSummon(1-tp) then return end
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sc=g:FilterSelect(tp,c511001673.filter,1,1,nil,e,1-tp):GetFirst()
		if sc then
			Duel.SpecialSummonStep(sc,0,tp,1-tp,false,false,POS_FACEUP_ATTACK)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			sc:RegisterEffect(e1)
			local sg=Duel.GetMatchingGroup(c511001673.filter,tp,LOCATION_HAND,0,nil,e,tp)
			if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(525110,1)) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				local sc2=sg:Select(tp,1,1,nil):GetFirst()
				Duel.BreakEffect()
				Duel.SpecialSummonStep(sc2,0,tp,tp,false,false,POS_FACEUP_ATTACK)
				local e2=Effect.CreateEffect(e:GetHandler())
				e2:SetType(EFFECT_TYPE_SINGLE)
				e2:SetCode(EFFECT_CANNOT_ATTACK)
				e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
				sc2:RegisterEffect(e2)
			end
			Duel.SpecialSummonComplete()
		end
		Duel.ShuffleHand(1-tp)
	end
end
