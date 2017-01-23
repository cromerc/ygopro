--アナザー・フュージョン
function c100000473.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000473.target)
	e1:SetOperation(c100000473.activate)
	c:RegisterEffect(e1)
	if not c100000473.global_check then
		c100000473.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_TO_DECK)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetOperation(c100000473.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c100000473.filter0(c,tp)
	return (c:IsControler(tp) or c:IsFaceup()) and c:IsCanBeFusionMaterial()
end
function c100000473.filter1(c,e,tp)
	return (c:IsControler(tp) or c:IsFaceup()) and c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c100000473.filter2(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
		and (c:IsControler(tp) or c:GetFlagEffect(511002577)>0)
end
function c100000473.filter3(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end
function c100000473.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local mg1=Duel.GetMatchingGroup(c100000473.filter0,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tp)
		local res=Duel.IsExistingMatchingCard(c100000473.filter2,tp,LOCATION_EXTRA,LOCATION_EXTRA,1,nil,e,tp,mg1,nil,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c100000473.filter2,tp,LOCATION_EXTRA,LOCATION_EXTRA,1,nil,e,tp,mg2,mf,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c100000473.activate(e,tp,eg,ep,ev,re,r,rp)
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local mg1=Duel.GetMatchingGroup(c100000473.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,e,tp)
	local sg1=Duel.GetMatchingGroup(c100000473.filter3,tp,LOCATION_EXTRA,LOCATION_EXTRA,nil,e,tp,mg1,nil,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c100000473.filter3,tp,LOCATION_EXTRA,LOCATION_EXTRA,nil,e,tp,mg2,mf,chkf)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local g=Duel.GetFieldGroup(tp,0,LOCATION_EXTRA)
		Duel.ConfirmCards(tp,g)
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
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetReset(RESET_PHASE+PHASE_END)
		e2:SetCountLimit(1)
		e2:SetLabelObject(tc)
		e2:SetOperation(c100000473.desop)
		Duel.RegisterEffect(e2,tp)
		tc:RegisterFlagEffect(100000473,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
end
function c100000473.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if g:GetFlagEffect(100000473)>0 then Duel.Destroy(g,REASON_EFFECT) end
end
function c100000473.cfilter(c)
	return c:IsLocation(LOCATION_EXTRA) and c:IsType(TYPE_FUSION)
end
function c100000473.checkop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c100000473.cfilter,nil)
	local tc=g:GetFirst()
	while tc do
		tc:RegisterFlagEffect(511002577,nil,0,0)
		tc=g:GetNext()
	end
end
