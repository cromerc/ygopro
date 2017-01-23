--Ancient Gear Rebirth Fusion
function c511001541.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCondition(c511001541.con)
	e1:SetTarget(c511001541.target)
	e1:SetOperation(c511001541.activate)
	c:RegisterEffect(e1)
end
function c511001541.con(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)==REASON_EFFECT and rp~=tp
end
function c511001541.cfilter(c,fc,e,tp)
	local fd=c:GetCode()
	if not c:IsSetCard(0x7) or c:IsPreviousPosition(POS_FACEDOWN) or c:GetPreviousControler()~=tp 
		or not c:IsCanBeEffectTarget(e) then return false end
	for i=1,fc.material_count do
		if fd==fc.material[i] then return true end
	end
	return false
end
function c511001541.spfilter(c,e,tp,eg)
	local ct=c.material_count
	return ct~=nil and eg:IsExists(c511001541.cfilter,1,nil,c,e,tp) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false)
end
function c511001541.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local sg=Duel.GetMatchingGroup(c511001541.spfilter,tp,LOCATION_EXTRA,0,nil,e,tp,eg)
	if chkc then return false end
	if chk==0 then return sg:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	local tcg=sg:GetFirst()
	local tg=Group.CreateGroup()
	while tcg do
		local g=eg:Filter(c511001541.cfilter,nil,tcg,e,tp)
		tg:Merge(g)
		tcg=sg:GetNext()
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tgf=tg:Select(tp,1,1,nil)
	Duel.SetTargetCard(tgf)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_EXTRA)
end
function c511001541.spfilter2(c,e,tp,tc)
	local fd=tc:GetCode()
	local ct=c.material_count
	if ct==nil or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) then return false end
	for i=1,c.material_count do
		if fd==c.material[i] then return true end
	end
	return false
end
function c511001541.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001541.spfilter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	end
end
