--Heat Crystals
function c511002360.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511002360.cost)
	e1:SetTarget(c511002360.target)
	e1:SetOperation(c511002360.activate)
	c:RegisterEffect(e1)
end
function c511002360.cfilter(c)
	return c:IsAttribute(ATTRIBUTE_FIRE) and c:IsAbleToRemoveAsCost()
end
function c511002360.filter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_FIRE) and c:IsType(TYPE_FUSION) and c:IsSetCard(0x3008) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
		and not c:IsHasEffect(EFFECT_NECRO_VALLEY) 
		and Duel.IsExistingMatchingCard(c511002360.cfilter,tp,LOCATION_GRAVE,0,2,c)
end
function c511002360.spfilter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_FIRE) and c:IsType(TYPE_FUSION) and c:IsSetCard(0x3008) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
		and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511002360.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002360.filter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil,e,tp) end
	local spg=Duel.GetMatchingGroup(c511002360.spfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,nil,e,tp)
	local g
	local remchk=false
	while g==nil or not remchk do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		g=Duel.SelectMatchingCard(tp,c511002360.cfilter,tp,LOCATION_GRAVE,0,2,2,nil)
		spg:Sub(g)
		if spg:GetCount()>0 then
			remchk=true
		end
		spg:Merge(g)
	end
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511002360.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511002360.spfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA+LOCATION_GRAVE)
end
function c511002360.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002360.spfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
