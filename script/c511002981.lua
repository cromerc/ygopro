--Pendulum Fusion
function c511002981.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(74335036,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002981.target)
	e1:SetOperation(c511002981.activate)
	c:RegisterEffect(e1)
	local f=Card.IsCanBeFusionMaterial
	Card.IsCanBeFusionMaterial=function(c,fc,ismon)
		if (c:GetSequence()==6 or c:GetSequence()==7) and c:IsLocation(LOCATION_SZONE) then
			return f(c,fc,true)
		end
		if c:IsCode(80604091) then return f(c,fc,true) end
		return f(c,fc,ismon)
	end
	local tf=Card.IsType
	Card.IsType=function(c,tpe)
		if c:IsLocation(LOCATION_SZONE) and c:GetSequence()>=6 then return tf(c,tpe) or bit.band(c:GetOriginalType(),tpe)==tpe end
		return tf(c,tpe)
	end
end
function c511002981.filter1(c,e)
	return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c511002981.filter2(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end
function c511002981.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local g1=Duel.GetFieldCard(tp,LOCATION_SZONE,6)
		local g2=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
		local g3=Duel.GetFieldCard(1-tp,LOCATION_SZONE,6)
		local g4=Duel.GetFieldCard(1-tp,LOCATION_SZONE,7)
		local mg1=Group.FromCards(g1,g2,g3,g4):Filter(c511002981.filter1,nil,e)
		local res=Duel.IsExistingMatchingCard(c511002981.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c511002981.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511002981.activate(e,tp,eg,ep,ev,re,r,rp)
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local g1=Duel.GetFieldCard(tp,LOCATION_SZONE,6)
	local g2=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
	local g3=Duel.GetFieldCard(1-tp,LOCATION_SZONE,6)
	local g4=Duel.GetFieldCard(1-tp,LOCATION_SZONE,7)
	local mg1=Group.FromCards(g1,g2,g3,g4):Filter(c511002981.filter1,nil,e)
	local sg1=Duel.GetMatchingGroup(c511002981.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c74335036.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf)
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
