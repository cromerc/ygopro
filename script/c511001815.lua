--Gate Guardian Ritual
function c511001815.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001815.target)
	e1:SetOperation(c511001815.activate)
	c:RegisterEffect(e1)
end
c511001815.fit_monster={25833572}
function c511001815.filter(c,e,tp,m)
	local cd=c:GetCode()
	if cd~=25833572 or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false) then return false end
	if m:IsContains(c) then
		m:RemoveCard(c)
		result=m:IsExists(Card.IsCode,1,nil,25955164) and m:IsExists(Card.IsCode,1,nil,62340868) 
			and m:IsExists(Card.IsCode,1,nil,98434877)
		m:AddCard(c)
	else
		result=m:IsExists(Card.IsCode,1,nil,25955164) and m:IsExists(Card.IsCode,1,nil,62340868) 
			and m:IsExists(Card.IsCode,1,nil,98434877)
	end
	return result
end
function c511001815.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg=Duel.GetRitualMaterial(tp)
		return Duel.IsExistingMatchingCard(c511001815.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp,mg)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511001815.activate(e,tp,eg,ep,ev,re,r,rp)
	local mg=Duel.GetRitualMaterial(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,c511001815.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp,mg)
	if tg:GetCount()>0 then
		local tc=tg:GetFirst()
		mg:RemoveCard(tc)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local mat1=mg:FilterSelect(tp,Card.IsCode,1,1,nil,25955164)
		local mat2=mg:FilterSelect(tp,Card.IsCode,1,1,nil,62340868)
		local mat3=mg:FilterSelect(tp,Card.IsCode,1,1,nil,98434877)
		mat1:Merge(mat2)
		mat1:Merge(mat3)
		tc:SetMaterial(mat1)
		Duel.ReleaseRitualMaterial(mat1)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
