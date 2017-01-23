--Delta Reactor
function c511000843.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000843.cost)
	e1:SetTarget(c511000843.target)
	e1:SetOperation(c511000843.activate)
	c:RegisterEffect(e1)
end
function c511000843.spcfilter(c,code)
	return c:IsCode(code) and c:IsAbleToGraveAsCost()
end
function c511000843.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3 
		and Duel.IsExistingMatchingCard(c511000843.spcfilter,tp,LOCATION_ONFIELD,0,1,nil,52286175)
		and Duel.IsExistingMatchingCard(c511000843.spcfilter,tp,LOCATION_ONFIELD,0,1,nil,15175429)
		and Duel.IsExistingMatchingCard(c511000843.spcfilter,tp,LOCATION_ONFIELD,0,1,nil,89493368) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c511000843.spcfilter,tp,LOCATION_ONFIELD,0,1,1,nil,52286175)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(tp,c511000843.spcfilter,tp,LOCATION_ONFIELD,0,1,1,nil,15175429)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g3=Duel.SelectMatchingCard(tp,c511000843.spcfilter,tp,LOCATION_ONFIELD,0,1,1,nil,89493368)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.SendtoGrave(g1,REASON_COST)
end
function c511000843.spfilter(c,e,tp)
	return c:IsCode(16898077) and c:IsCanBeSpecialSummoned(e,0,tp,true,true) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511000843.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000843.spfilter,tp,0x13,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,0,tp,0x13)
end
function c511000843.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000843.spfilter,tp,0x13,0,1,1,nil,e,tp)
	if g:GetCount()~=0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DESTROY_REPLACE)
		e1:SetCountLimit(1)
		e1:SetTarget(c511000843.reptg)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		g:GetFirst():RegisterEffect(e1)
		g:GetFirst():CompleteProcedure()
	end
end
function c511000843.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	return true
end
