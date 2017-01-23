--磁力融合
function c100000571.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100000571.cost)
	e1:SetTarget(c100000571.target)
	e1:SetOperation(c100000571.activate)
	c:RegisterEffect(e1)
end
function c100000571.filter(c,code)
	return c:IsCode(code)
end
function c100000571.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c100000571.filter,1,nil,450000350)
	 and Duel.CheckReleaseGroup(tp,c100000571.filter,1,nil,450000351)
	 and Duel.CheckReleaseGroup(tp,c100000571.filter,1,nil,450000352)	end
	local rg1=Duel.SelectReleaseGroup(tp,c100000571.filter,1,1,nil,450000350)
	local rg2=Duel.SelectReleaseGroup(tp,c100000571.filter,1,1,nil,450000351)
	local rg3=Duel.SelectReleaseGroup(tp,c100000571.filter,1,1,nil,450000352)
	rg1:Merge(rg2)
	rg1:Merge(rg3)
	Duel.Release(rg1,REASON_COST)
end
function c100000571.spfilter(c,e,tp)
	return c:IsCode(100000570) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c100000571.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=(e:GetLabel()==1) and 0 or -1
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c100000571.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp)
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>chkf
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	e:SetLabel(0)
end
function c100000571.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c100000571.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if sg:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SpecialSummon(sg,SUMMON_TYPE_FUSION,tp,tp,true,false,POS_FACEUP)
		sg:GetFirst():CompleteProcedure()
	end
end
