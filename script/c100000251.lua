--レベル・ソウル
function c100000251.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100000251.cost)
	e1:SetTarget(c100000251.target)
	e1:SetOperation(c100000251.activate)
	c:RegisterEffect(e1)
end
function c100000251.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c100000251.rmfilter(c,e,tp)
	if not c:IsSetCard(0x41) or not c:IsAbleToRemoveAsCost() then return false end
	local code=c:GetCode()
	local class=_G["c"..code]
	return Duel.IsExistingMatchingCard(c100000251.spfilter,tp,LOCATION_DECK,0,1,nil,class,e,tp)
end
function c100000251.spfilter(c,class,e,tp)
	local code=c:GetCode()
	for i=1,class.lvupcount do
		if code==class.lvup[i] then	return c:IsCanBeSpecialSummoned(e,0,tp,true,false) end
	end
	return false
end
function c100000251.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.CheckReleaseGroup(tp,nil,1,nil) and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 
			and Duel.IsExistingMatchingCard(c100000251.rmfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	local g1=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c100000251.rmfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	local code=g2:GetFirst():GetCode()
	Duel.Release(g1,REASON_COST)
	Duel.Remove(g2,POS_FACEUP,REASON_COST)
	Duel.SetTargetParam(code)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c100000251.activate(e,tp,eg,ep,ev,re,r,rp)
	local code=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local class=_G["c"..code]
	if class==nil or class.lvupcount==nil then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000251.spfilter,tp,LOCATION_DECK,0,1,1,nil,class,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
