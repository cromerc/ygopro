--Double Fusion
function c511001334.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001334.cost)
	e1:SetTarget(c511001334.target)
	e1:SetOperation(c511001334.activate)
	c:RegisterEffect(e1)
end
function c511001334.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c511001334.filter1(c,e)
	return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c511001334.filter2(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end
function c511001334.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local mg1=Duel.GetMatchingGroup(Card.IsCanBeFusionMaterial,tp,LOCATION_HAND+LOCATION_MZONE,0,nil)
		local res=Duel.IsExistingMatchingCard(c511001334.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c511001334.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511001334.activate(e,tp,eg,ep,ev,re,r,rp)
	if true then
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local mg1=Duel.GetMatchingGroup(c511001334.filter1,tp,LOCATION_HAND+LOCATION_MZONE,0,nil,e)
		local sg1=Duel.GetMatchingGroup(c511001334.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
		local mg2=nil
		local sg2=nil
		local ce=Duel.GetChainMaterial(tp)
		if ce~=nil then
			local fgroup=ce:GetTarget()
			mg2=fgroup(ce,e,tp)
			local mf=ce:GetValue()
			sg2=Duel.GetMatchingGroup(c511001334.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf)
		end
		if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
			local sg=sg1:Clone()
			if sg2 then sg:Merge(sg2) end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local tg=sg:Select(tp,1,1,nil)
			local tc=tg:GetFirst()
			if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
				local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
				tc:SetMaterial(mat1)
				Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
				Duel.BreakEffect()
				Duel.SpecialSummonStep(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
				tc:SetStatus(STATUS_SPSUMMON_STEP,false)
			else
				local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,nil,chkf)
				local fop=ce:GetOperation()
				fop(ce,e,tp,tc,mat2)
			end
			tc:CompleteProcedure()
		else
			local cg1=Duel.GetFieldGroup(tp,LOCATION_HAND+LOCATION_MZONE,0)
			local cg2=Duel.GetFieldGroup(tp,LOCATION_EXTRA,0)
			if cg1:GetCount()>1 and cg2:IsExists(Card.IsFacedown,1,nil)
				and Duel.IsPlayerCanSpecialSummon(tp) and not Duel.IsPlayerAffectedByEffect(tp,27581098) then
				Duel.ConfirmCards(1-tp,cg1)
				Duel.ConfirmCards(1-tp,cg2)
				Duel.ShuffleHand(tp)
			end
		end
	end
	local tchkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local tmg1=Duel.GetMatchingGroup(Card.IsCanBeFusionMaterial,tp,LOCATION_HAND+LOCATION_MZONE,0,nil)
	local res=Duel.IsExistingMatchingCard(c511001334.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,tmg1,nil,tchkf)
	if not res then
		local ce=Duel.GetChainMaterial(tp)
		if ce~=nil then
			local fgroup=ce:GetTarget()
			local mg2=fgroup(tce,e,tp)
			local mf=ce:GetValue()
			res=Duel.IsExistingMatchingCard(c511001334.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,tchkf)
		end
	end
	if res and not Duel.IsPlayerAffectedByEffect(tp,59822133) and Duel.SelectYesNo(tp,aux.Stringid(33550694,0)) then
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local mg1=Duel.GetMatchingGroup(c511001334.filter1,tp,LOCATION_HAND+LOCATION_MZONE,0,nil,e)
		local sg1=Duel.GetMatchingGroup(c511001334.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
		local mg2=nil
		local sg2=nil
		local ce=Duel.GetChainMaterial(tp)
		if ce~=nil then
			local fgroup=ce:GetTarget()
			mg2=fgroup(ce,e,tp)
			local mf=ce:GetValue()
			sg2=Duel.GetMatchingGroup(c511001334.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf)
		end
		if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
			local sg=sg1:Clone()
			if sg2 then sg:Merge(sg2) end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local tg=sg:Select(tp,1,1,nil)
			local tc=tg:GetFirst()
			if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
				local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
				tc:SetMaterial(mat1)
				Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
				Duel.BreakEffect()
				Duel.SpecialSummonStep(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
			else
				local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,nil,chkf)
				local fop=ce:GetOperation()
				fop(ce,e,tp,tc,mat2)
			end
			tc:CompleteProcedure()
		else
			local cg1=Duel.GetFieldGroup(tp,LOCATION_HAND+LOCATION_MZONE,0)
			local cg2=Duel.GetFieldGroup(tp,LOCATION_EXTRA,0)
			if cg1:GetCount()>1 and cg2:IsExists(Card.IsFacedown,1,nil)
				and Duel.IsPlayerCanSpecialSummon(tp) and not Duel.IsPlayerAffectedByEffect(tp,27581098) then
				Duel.ConfirmCards(1-tp,cg1)
				Duel.ConfirmCards(1-tp,cg2)
				Duel.ShuffleHand(tp)
			end
		end
	end
	Duel.SpecialSummonComplete()
end
