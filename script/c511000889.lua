--Pheromone Wasp
function c511000889.initial_effect(c)
	--sp summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetCondition(c511000889.condition)
	e2:SetOperation(c511000889.operation)
	c:RegisterEffect(e2)
end
function c511000889.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil and Duel.GetAttacker()==e:GetHandler()
end
function c511000889.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(511000889,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511000889.sptg)
	e1:SetOperation(c511000889.spop)
	e1:SetReset(RESET_PHASE+PHASE_BATTLE)
	e:GetHandler():RegisterEffect(e1)
end
function c511000889.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsRace(RACE_INSECT) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000889.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511000889.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000889.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		else
			Duel.Destroy(g,REASON_EFFECT)
		end
	else
		local cg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
		Duel.ConfirmCards(1-tp,cg)
		Duel.ShuffleDeck(tp)
	end
end
