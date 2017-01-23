--Numbers Evaille
function c511001611.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001611.target)
	e1:SetOperation(c511001611.activate)
	c:RegisterEffect(e1)
end
function c511001611.numfilter(c)
	return c.xyz_number
end
function c511001611.spfilterchk(c,e,tp,ntg)
	return c:IsSetCard(0x48) and c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
		and ntg:CheckWithSumEqual(c511001611.numfilter,c.xyz_number,1,99)
end
function c511001611.numfilter2(c)
	return c.xyz_number and c.xyz_number==0
end
function c511001611.spfilterchk(c,e,tp,ntg)
	return c:IsSetCard(0x48) and c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
		and c.xyz_number and c.xyz_number==0 and ntg:IsExists(c511001611.numfilter2,1,c)
end
function c511001611.afilter(c)
	return c:IsSetCard(0x48) and c:IsType(TYPE_XYZ)
end
function c511001611.spfilter(c,e,tp,g,ct)
	return c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
		and c.xyz_number==ct and not g:IsContains(c)
end
function c511001611.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local nt=Duel.GetMatchingGroup(c511001611.afilter,tp,LOCATION_EXTRA,0,nil)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and	(Duel.IsExistingMatchingCard(c511001611.spfilterchk,tp,LOCATION_EXTRA,0,1,nil,e,tp,nt) 
		or Duel.IsExistingMatchingCard(c511001611.spfilterchk2,tp,LOCATION_EXTRA,0,1,nil,e,tp,nt)) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_EXTRA)
end
function c511001611.activate(e,tp,eg,ep,ev,re,r,rp)
	local nt=Duel.GetMatchingGroup(c511001611.afilter,tp,LOCATION_EXTRA,0,nil)
	local spg=Duel.GetMatchingGroup(c511001611.spfilterchk,tp,LOCATION_EXTRA,0,nil,e,tp,nt)
	local spg2=Duel.GetMatchingGroup(c511001611.spfilterchk2,tp,LOCATION_EXTRA,0,nil,e,tp,nt)
	if spg:GetCount()<=0 or spg:GetCount()<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local sg=nt:Select(tp,1,99,nil)
	while not Duel.IsExistingMatchingCard(c511001611.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,sg,sg:GetSum(c511001611.numfilter)) do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		sg=nt:Select(tp,1,99,nil)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001611.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,sg,sg:GetSum(c511001611.numfilter))
	local tc=g:GetFirst()
	if tc then
		tc:SetMaterial(sg)
		Duel.SpecialSummon(tc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		Duel.Overlay(tc,sg)
		tc:CompleteProcedure()
	end
end
