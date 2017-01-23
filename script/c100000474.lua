--フュージョン・バース
function c100000474.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000474.target)
	e1:SetOperation(c100000474.activate)
	c:RegisterEffect(e1)
end
function c100000474.filter1(c,e)
	return c:IsCanBeFusionMaterial() and c:IsLocation(LOCATION_GRAVE) and not c:IsImmuneToEffect(e)
end
function c100000474.filter2(c,e,tp,m,chkf)
	return c:IsType(TYPE_FUSION) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false)
		and c:CheckFusionMaterial(m,nil,chkf)
end
function c100000474.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,5) end
	Duel.DiscardDeck(tp,5,REASON_COST)
	local g=Duel.GetOperatedGroup()
	local mg1=g:Filter(c100000474.filter1,nil,e)
	if mg1:GetCount()==0 then return false end
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local res=Duel.IsExistingMatchingCard(c100000474.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				res=Duel.IsExistingMatchingCard(c100000474.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,chkf)
			end
		end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c100000474.activate(e,tp,eg,ep,ev,re,r,rp)
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local g=Duel.GetOperatedGroup()
	local mg1=g:Filter(c100000474.filter1,nil,e)
	local sg1=Duel.GetMatchingGroup(c100000474.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		sg2=Duel.GetMatchingGroup(c100000474.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,chkf)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
