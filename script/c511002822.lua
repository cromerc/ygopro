--Prayer to the Evil Spirits
function c511002822.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(74335036,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002822.target)
	e1:SetOperation(c511002822.activate)
	c:RegisterEffect(e1)
end
function c511002822.filter1(c,e)
	return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e) 
		and (c:IsFusionCode(96470883) or c:IsFusionCode(49674183) or c:IsHasEffect(EFFECT_FUSION_SUBSTITUTE))
end
function c511002822.check(c,g1,g2,chkf)
	local tc1=g1:GetFirst()
	while tc1 do
		local tc2=g2:GetFirst()
		while tc2 do
			local m=Group.CreateGroup()
			m:AddCard(tc1)
			m:AddCard(tc2)
			if c:CheckFusionMaterial(m,nil,chkf) then
				return true
			end
			tc2=g2:GetNext()
		end
		tc1=g1:GetNext()
	end
	return false
end
function c511002822.checkop(c,g1,g2,chkf)
	local tc1=g1:GetFirst()
	while tc1 do
		local tc2=g2:GetFirst()
		while tc2 do
			local m=Group.CreateGroup()
			m:AddCard(tc1)
			m:AddCard(tc2)
			if c:CheckFusionMaterial(m,nil,chkf) then
				tc1:RegisterFlagEffect(511002822,RESET_CHAIN,0,0)
				tc2:RegisterFlagEffect(511002822,RESET_CHAIN,0,0)
			end
			tc2=g2:GetNext()
		end
		tc1=g1:GetNext()
	end
end
function c511002822.filter2(c,e,tp,m1,m2,f,chkf)
	return c:IsType(TYPE_FUSION) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c511002822.check(c,m1,m2,chkf)
end
function c511002822.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local mg1=Duel.GetMatchingGroup(c511002822.filter1,tp,LOCATION_HAND,0,nil,e)
		local mg2=Duel.GetMatchingGroup(c511002822.filter1,tp,LOCATION_GRAVE,0,nil,e)
		local res=Duel.IsExistingMatchingCard(c511002822.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,mg2,nil,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg3=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c511002822.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg3,Group.CreateGroup(),mf,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511002822.matfilter1(c)
	return c:GetFlagEffect(511002822)>0
end
function c511002822.matfilter2(c,fusc,m,chkf)
	m:AddCard(c)
	local chk=false
	if fusc:CheckFusionMaterial(m,nil,chkf) then
		chk=true
	end
	m:RemoveCard(c)
	return c:GetFlagEffect(511002822)>0  and chk
end
function c511002822.activate(e,tp,eg,ep,ev,re,r,rp)
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local mg1=Duel.GetMatchingGroup(c511002822.filter1,tp,LOCATION_HAND,0,nil,e)
	local mg2=Duel.GetMatchingGroup(c511002822.filter1,tp,LOCATION_GRAVE,0,nil,e)
	local sg1=Duel.GetMatchingGroup(c511002822.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,mg2,nil,chkf)
	local mg3=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c511002822.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg3,Group.CreateGroup(),mf,chkf)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			c511002822.checkop(tc,mg1,mg2,chkf)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
			local mat1=mg1:FilterSelect(tp,c511002822.matfilter1,1,1,nil)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
			local mat2=mg2:FilterSelect(tp,c511002822.matfilter2,1,1,nil,tc,mat1,chkf)
			mat1:Merge(mat2)
			tc:SetMaterial(mat1)
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg3,nil,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	end
end
