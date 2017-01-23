--Release & Reverse
function c511002758.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002758.target)
	e1:SetOperation(c511002758.activate)
	c:RegisterEffect(e1)
end
function c511002758.filter(c)
	return c:IsReleasableByEffect() and not c:IsHasEffect(EFFECT_SPSUMMON_CONDITION)
end
function c511002758.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511002758.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end
function c511002758.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,c511002758.filter,tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		if Duel.Release(g,REASON_EFFECT)>0 then
			local atk=g:GetFirst():GetAttack()
			Duel.Damage(tp,atk,REASON_EFFECT)
			Duel.BreakEffect()
			if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 then
				Duel.SpecialSummon(g,0,1-tp,1-tp,false,false,POS_FACEUP)
			end
		end
	end
end
