--Coded by Lyris
--fixed by MLD
--Drop Exchange
function c511007030.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511007030.cost)
	e1:SetTarget(c511007030.target)
	e1:SetOperation(c511007030.operation)
	c:RegisterEffect(e1)
end
function c511007030.filter(c,g,e,tp)
	return c:GetLevel()>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and g:CheckWithSumEqual(Card.GetLevel,c:GetLevel(),2,99)
end
function c511007030.cfilter(c)
	return c:GetLevel()>0 and c:IsAbleToGraveAsCost()
end
function c511007030.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local rg=Duel.GetMatchingGroup(c511007030.cfilter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return Duel.IsExistingMatchingCard(c511007030.filter,tp,LOCATION_HAND,0,1,nil,rg,e,tp) end
	local g=Group.CreateGroup()
	local lv=0
	repeat
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		g=Duel.SelectMatchingCard(tp,c511007030.cfilter,tp,LOCATION_MZONE,0,2,99,nil)
		lv=g:GetSum(Card.GetLevel)
	until Duel.IsExistingMatchingCard(c511007030.spfilter,tp,LOCATION_HAND,0,1,nil,lv,e,tp)
	e:SetLabel(lv)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511007030.spfilter(c,lv,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and lv==c:GetLevel()
end
function c511007030.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2 end
	Duel.SetTargetParam(e:GetLabel())
	e:SetLabel(0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end 
function c511007030.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local lv=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511007030.spfilter,tp,LOCATION_HAND,0,1,1,nil,lv,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
