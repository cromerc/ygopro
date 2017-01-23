--Stairway to the Underworld
function c511000921.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511000921.condition)
	e1:SetTarget(c511000921.target)
	e1:SetOperation(c511000921.activate)
	c:RegisterEffect(e1)
end
function c511000921.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c511000921.filter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000921.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsExistingMatchingCard(c511000921.filter,tp,LOCATION_DECK,0,1,nil,e,tp,44330098) 
		and Duel.IsExistingMatchingCard(c511000921.filter,tp,LOCATION_DECK,0,1,nil,e,tp,511002636) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c511000921.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g1=Duel.GetMatchingGroup(c511000921.filter,tp,LOCATION_DECK,0,nil,e,tp,44330098)
	local g2=Duel.GetMatchingGroup(c511000921.filter,tp,LOCATION_DECK,0,nil,e,tp,511002636)
	if g1:GetCount()>0 and g2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg2=g2:Select(tp,1,1,nil)
		sg1:Merge(sg2)
		Duel.SpecialSummon(sg1,0,tp,tp,false,false,POS_FACEUP)
	end
end
