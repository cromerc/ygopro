--Royal Straight
function c511000088.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000088.cost)
	e1:SetTarget(c511000088.target)
	e1:SetOperation(c511000088.activate)
	c:RegisterEffect(e1)
end
function c511000088.filter(c,e,tp)
	return c:IsCode(511000089) and c:IsCanBeSpecialSummoned(e,0,tp,true,true) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511000088.filter1(c)
	return c:IsCode(25652259) and c:IsPosition(POS_FACEUP_ATTACK)
end
function c511000088.filter2(c)
	return c:IsCode(64788463) and c:IsPosition(POS_FACEUP_ATTACK)
end
function c511000088.filter3(c)
	return c:IsCode(90876561) and c:IsPosition(POS_FACEUP_ATTACK)
end
function c511000088.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c511000088.filter1,1,nil) 
	and Duel.CheckReleaseGroup(tp,c511000088.filter2,1,nil) 
	and Duel.CheckReleaseGroup(tp,c511000088.filter3,1,nil) end
	local g1=Duel.SelectReleaseGroup(tp,c511000088.filter1,1,1,nil)
	local g2=Duel.SelectReleaseGroup(tp,c511000088.filter2,1,1,nil)
	local g3=Duel.SelectReleaseGroup(tp,c511000088.filter3,1,1,nil)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.Release(g1,REASON_COST)
end
function c511000088.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
	and Duel.IsExistingMatchingCard(c511000088.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c511000088.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000088.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	end
end
