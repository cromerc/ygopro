---影依融合
function c501001059.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c501001059.condition)
	e1:SetCost(c501001059.cost)
	e1:SetTarget(c501001059.target)
	e1:SetOperation(c501001059.activate)
	c:RegisterEffect(e1)
end	
function c501001059.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return Duel.GetFlagEffect(tp,501001059)==0
end
function c501001059.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.GetFlagEffect(tp,501001059)==0 end
	Duel.RegisterFlagEffect(tp,501001059,RESET_PHASE+PHASE_END,0,1)
end	
function c501001059.filter0(c,e)
	return c:IsPreviousLocation(LOCATION_EXTRA)
	and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c501001059.filter1(c,e)
	return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c501001059.filter2(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION)
	and (not f or f(c))
	and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false)
	and c:CheckFusionMaterial(m,nil,chkf)
	and c:IsSetCard(0x9b)
end
function c501001059.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local mg1=Group.CreateGroup()
		if Duel.IsExistingMatchingCard(c501001059.filter0,tp,0,LOCATION_MZONE,1,nil) then
			mg=Duel.GetMatchingGroup(c501001059.filter1,tp,LOCATION_HAND+LOCATION_MZONE+LOCATION_DECK,0,nil,e)
			mg1:Merge(mg)
		else
			mg=Duel.GetMatchingGroup(c501001059.filter1,tp,LOCATION_HAND+LOCATION_MZONE,0,nil,e)
			mg1:Merge(mg)
		end
		local res=Duel.IsExistingMatchingCard(c501001059.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c501001059.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c501001059.activate(e,tp,eg,ep,ev,re,r,rp)
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local mg1=Group.CreateGroup()
	if Duel.IsExistingMatchingCard(c501001059.filter0,tp,0,LOCATION_MZONE,1,nil) then
		mg=Duel.GetMatchingGroup(c501001059.filter1,tp,LOCATION_HAND+LOCATION_MZONE+LOCATION_DECK,0,nil,e)
		mg1:Merge(mg)
	else
		mg=Duel.GetMatchingGroup(c501001059.filter1,tp,LOCATION_HAND+LOCATION_MZONE,0,nil,e)
		mg1:Merge(mg)
	end
	local sg1=Duel.GetMatchingGroup(c501001059.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c501001059.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf)
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
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,nil,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	end
end
