--Flame Egg Level 5
function c511001733.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetCondition(c511001733.condition)
	e1:SetTarget(c511001733.target)
	e1:SetOperation(c511001733.activate)
	c:RegisterEffect(e1)
end
function c511001733.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and bit.band(r,REASON_EFFECT)~=0
end
function c511001733.filter(c,e,tp)
	return c:GetLevel()==5 and c:IsCanBeSpecialSummoned(e,0,1-tp,false,false)
end
function c511001733.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 
		and Duel.IsPlayerCanSpecialSummonMonster(1-tp,0,0,TYPE_MONSTER,0,0,5,0,0) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,1-tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c511001733.activate(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanSpecialSummonMonster(1-tp,0,0,TYPE_MONSTER,0,0,5,0,0) then return end
	local g=Duel.GetMatchingGroup(c511001733.filter,1-tp,LOCATION_HAND,0,nil,e,tp)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 and g:GetCount()>0 and Duel.SelectYesNo(1-tp,aux.Stringid(20758643,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(1-tp,1,1,nil)
		Duel.SpecialSummon(sg,0,1-tp,1-tp,false,false,POS_FACEUP)
	else
		Duel.Damage(1-tp,500,REASON_EFFECT)
	end
end
