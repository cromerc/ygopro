--Illegal Summon
function c511001931.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001931.target)
	e1:SetOperation(c511001931.activate)
	c:RegisterEffect(e1)
end
function c511001931.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001931.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001931.filter,tp,LOCATION_DECK,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 
		and Duel.IsPlayerCanSpecialSummon(1-tp) and Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,PLAYER_ALL,LOCATION_DECK)
end
function c511001931.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0 then return end
	local g1=Duel.GetMatchingGroup(c511001931.filter,tp,LOCATION_DECK,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(c511001931.filter,tp,0,LOCATION_DECK,nil,e,tp)
	if g1:GetCount()<=0 or g2:GetCount()<=0 then
		if g1:GetCount()<=0 then
			local cg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
			Duel.ConfirmCards(1-tp,cg)
			Duel.ConfirmCards(tp,cg)
			Duel.ShuffleDeck(tp)
		end
		if g2:GetCount()<=0 then
			local cg=Duel.GetFieldGroup(1-tp,LOCATION_DECK,0)
			Duel.ConfirmCards(tp,cg)
			Duel.ConfirmCards(1-tp,cg)
			Duel.ShuffleDeck(1-tp)
		end
		return
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sp1=g1:Select(tp,1,1,nil):GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sp2=g2:Select(1-tp,1,1,nil):GetFirst()
	if Duel.SpecialSummonStep(sp1,0,1-tp,1-tp,false,false,POS_FACEUP) 
		and Duel.SpecialSummonStep(sp2,0,1-tp,tp,false,false,POS_FACEUP) then
		Duel.SpecialSummonComplete()
	end
end
