--Underworld Resonance - Synchro Fusion
function c511002620.initial_effect(c)
	--synchro effect
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002620.target)
	e1:SetOperation(c511002620.activate)
	c:RegisterEffect(e1)
end
function c511002620.chk(e,tp)
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	for i=0,4 do
		for j=0,4 do
			local c1=Duel.GetFieldCard(tp,LOCATION_MZONE,i)
			local c2=Duel.GetFieldCard(tp,LOCATION_MZONE,j)
			local g=Group.FromCards(c1,c2)
			if c1 and c2 and c1:IsCanBeFusionMaterial() and c2:IsCanBeFusionMaterial() then
				if Duel.IsExistingMatchingCard(c511002620.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,g,nil,chkf) 
					and Duel.IsExistingMatchingCard(c511002620.synfilter,tp,LOCATION_EXTRA,0,1,nil,g) then
					return true
				end
			end
		end
	end
	for i=0,4 do
		for j=0,4 do
			for k=0,4 do
				local c1=Duel.GetFieldCard(tp,LOCATION_MZONE,i)
				local c2=Duel.GetFieldCard(tp,LOCATION_MZONE,j)
				local c3=Duel.GetFieldCard(tp,LOCATION_MZONE,k)
				local g=Group.FromCards(c1,c2,c3)
				if c1 and c2 and c3 and c1:IsCanBeFusionMaterial() and c2:IsCanBeFusionMaterial() 
					and c3:IsCanBeFusionMaterial() then
					if Duel.IsExistingMatchingCard(c511002620.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,g,nil,chkf) 
						and Duel.IsExistingMatchingCard(c511002620.synfilter,tp,LOCATION_EXTRA,0,1,nil,g) then
						return true
					end
				end
			end
		end
	end
	for i=0,4 do
		for j=0,4 do
			for k=0,4 do
				for l=0,4 do
					local c1=Duel.GetFieldCard(tp,LOCATION_MZONE,i)
					local c2=Duel.GetFieldCard(tp,LOCATION_MZONE,j)
					local c3=Duel.GetFieldCard(tp,LOCATION_MZONE,k)
					local c4=Duel.GetFieldCard(tp,LOCATION_MZONE,l)
					local g=Group.FromCards(c1,c2,c3,c4)
					if c1 and c2 and c3 and c4 and c1:IsCanBeFusionMaterial() and c2:IsCanBeFusionMaterial() 
						and c3:IsCanBeFusionMaterial() and c4:IsCanBeFusionMaterial() then
						if Duel.IsExistingMatchingCard(c511002620.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,g,nil,chkf) 
							and Duel.IsExistingMatchingCard(c511002620.synfilter,tp,LOCATION_EXTRA,0,1,nil,g) then
							return true
						end
					end
				end
			end
		end
	end
	local c1=Duel.GetFieldCard(tp,LOCATION_MZONE,0)
	local c2=Duel.GetFieldCard(tp,LOCATION_MZONE,1)
	local c3=Duel.GetFieldCard(tp,LOCATION_MZONE,2)
	local c4=Duel.GetFieldCard(tp,LOCATION_MZONE,3)
	local c5=Duel.GetFieldCard(tp,LOCATION_MZONE,4)
	local g=Group.FromCards(c1,c2,c3,c4,c5)
	return c1 and c2 and c3 and c4 and c5 and c1:IsCanBeFusionMaterial() and c2:IsCanBeFusionMaterial() and c3:IsCanBeFusionMaterial() 
		and c4:IsCanBeFusionMaterial() and c5:IsCanBeFusionMaterial() 
		and Duel.IsExistingMatchingCard(c511002620.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,g,nil,chkf) 
		and Duel.IsExistingMatchingCard(c511002620.synfilter,tp,LOCATION_EXTRA,0,1,nil,g)
end
function c511002620.filter1(c,e)
	return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c511002620.filter2(c,e,tp,m,f)
	return c:IsType(TYPE_FUSION) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil)
end
function c511002620.synfilter(c,mg)
	return c:IsSynchroSummonable(nil,mg) and mg:CheckWithSumEqual(Card.GetSynchroLevel,c:GetLevel(),mg:GetCount(),mg:GetCount(),c)
end
function c511002620.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return c511002620.chk(e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_EXTRA)
end
function c511002620.activate(e,tp,eg,ep,ev,re,r,rp)
	if not c511002620.chk(e,tp) then return end
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local mg1=Duel.GetMatchingGroup(c511002620.filter1,tp,LOCATION_MZONE,0,nil,e)
	local sg1=Duel.GetMatchingGroup(c511002620.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	if sg1:GetCount()>0 then
		local sg=sg1:Clone()
		local tc2=nil
		local tc=nil
		local mat1=Group.CreateGroup()
		while not tc or not tc2 do
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			tc=sg:Select(tp,1,1,nil):GetFirst()
			mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
			tc2=Duel.SelectMatchingCard(tp,c511002620.synfilter,tp,LOCATION_EXTRA,0,1,1,nil,mat1):GetFirst()
		end
		tc:SetMaterial(mat1)
		tc2:SetMaterial(mat1)
		Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION+REASON_SYNCHRO)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		Duel.SpecialSummon(tc2,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)
		tc:CompleteProcedure()
		tc2:CompleteProcedure()
	end
end
