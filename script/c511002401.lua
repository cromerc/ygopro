--Neospace Wave
function c511002401.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002401.condition)
	e1:SetTarget(c511002401.target)
	e1:SetOperation(c511002401.activate)
	c:RegisterEffect(e1)
end
function c511002401.filter(c)
	return c:IsSetCard(0x1f) and c:IsType(TYPE_MONSTER)
end
function c511002401.condition(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	local neoct=Duel.GetMatchingGroupCount(c511002401.filter,tp,LOCATION_DECK,0,nil)
	return neoct>ct
end
function c511002401.spfilter(c,e,tp)
	return c:IsSetCard(0x1f) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002401.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)+mg:GetCount()
	local sg=Duel.GetMatchingGroup(c511002401.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if chk==0 then return mg:GetCount()>0 and mg:FilterCount(Card.IsAbleToGrave,nil)==mg:GetCount() 
		and sg:CheckWithSumEqual(Card.GetAttack,mg:GetSum(Card.GetAttack)/2,1,ft) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,mg,mg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511002401.activate(e,tp,eg,ep,ev,re,r,rp)
	local mg=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	local sg=Duel.GetMatchingGroup(c511002401.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if Duel.SendtoGrave(mg,REASON_EFFECT)>0 then
		local g=mg:Filter(Card.IsLocation,nil,LOCATION_GRAVE)
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		Duel.BreakEffect()
		if ft>0 then
			local spg=sg:SelectWithSumEqual(tp,Card.GetAttack,g:GetSum(Card.GetAttack)/2,1,ft)
			Duel.SpecialSummon(spg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
