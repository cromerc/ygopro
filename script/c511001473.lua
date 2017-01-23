--Necro Dollmeister
function c511001473.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511001473.condition)
	e1:SetTarget(c511001473.target)
	e1:SetOperation(c511001473.activate)
	c:RegisterEffect(e1)
end
function c511001473.cfilter(c,tp)
	return c:IsSetCard(0x220b) and c:GetPreviousControler()==tp
end
function c511001473.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001473.cfilter,1,nil,tp)
end
function c511001473.filter(c,e,tp)
	return c:IsSetCard(0x220b) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001473.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.IsExistingMatchingCard(c511001473.filter,tp,LOCATION_DECK,0,2,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c511001473.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetMatchingGroup(c511001473.filter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,2,2,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
