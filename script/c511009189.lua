--Mystic Revolution
function c511009189.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511009189.cost)
	e1:SetTarget(c511009189.target)
	e1:SetOperation(c511009189.activate)
	c:RegisterEffect(e1)
end
c511009189.list={[511009183]=511009186,[511009184]=511009187,[511009185]=511009188}
function c511009189.cfilter(c)
	return c:IsCode(511009183) or c:IsCode(511009184) or c:IsCode(511009185) and
	Duel.IsExistingMatchingCard(c511009189.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,c511009189.list[c:GetCode()],e,tp)
end
function c511009189.spfilter(c,code,e,tp)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511009189.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c511009189.cfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c511009189.cfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
	e:SetLabel(g:GetFirst():GetCode())
end
function c511009189.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c511009189.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local code=e:GetLabel()
	local g=Duel.SelectMatchingCard(tp,c511009189.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,code,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	end
end
