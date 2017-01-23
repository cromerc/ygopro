--Temptation of the Goddess
function c511001794.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001794.target)
	e1:SetOperation(c511001794.operation)
	c:RegisterEffect(e1)
end
function c511001794.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 
		and Duel.IsPlayerCanSpecialSummon(1-tp) end
end
function c511001794.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,1-tp,false,false)
end
function c511001794.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511001794.filter,tp,0,LOCATION_HAND,nil,e,tp)
	local hg=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	Duel.ConfirmCards(tp,hg)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(57554544,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg,0,1-tp,1-tp,false,false,POS_FACEUP_ATTACK)
	end
	Duel.ShuffleHand(1-tp)
end
