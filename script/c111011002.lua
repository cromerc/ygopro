--カオス・フィールド
function c111011002.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--XYZ
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(111011002,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c111011002.spcost)
	e2:SetTarget(c111011002.sptg)
	e2:SetOperation(c111011002.spop)
	c:RegisterEffect(e2)
	--XYZ
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(111011002,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c111011002.xyztg)
	e3:SetOperation(c111011002.xyzop)
	c:RegisterEffect(e3)		
end
function c111011002.ofilter(c,tp)
	return c:CheckRemoveOverlayCard(tp,1,REASON_COST) and c:IsSetCard(0x1048) and c:IsFaceup()
end
function c111011002.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c111011002.ofilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	local tc=Duel.SelectMatchingCard(tp,c111011002.ofilter,tp,LOCATION_MZONE,0,1,1,nil,tp):GetFirst()
	tc:RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c111011002.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c111011002.filter(c,e,tp)
	return c:IsSetCard(0x48) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c111011002.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local xyzg=Duel.GetMatchingGroup(c111011002.filter,tp,0,LOCATION_EXTRA,nil,e,tp)
	if xyzg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local xyz=xyzg:RandomSelect(tp,1):GetFirst()
		if Duel.SpecialSummonStep(xyz,0,tp,tp,false,false,POS_FACEUP) then	
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			xyz:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			xyz:RegisterEffect(e2)
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e3:SetRange(LOCATION_MZONE)
			e3:SetCode(EVENT_PHASE+PHASE_END)
			e3:SetOperation(c111011002.desop)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			e3:SetCountLimit(1)
			xyz:RegisterEffect(e3)
			local e4=e2:Clone()
			e4:SetCode(EFFECT_CANNOT_ATTACK)
			xyz:RegisterEffect(e4)
			xyz:RegisterFlagEffect(111011002,RESET_EVENT+0x1fe0000,0,1)
			Duel.SpecialSummonComplete()
		end
	else
		local cg=Duel.GetFieldGroup(tp,0,LOCATION_EXTRA)
		Duel.ConfirmCards(tp,cg)
	end	
end
function c111011002.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c111011002.tgfilter(c,e,tp)
	local rank=c:GetRank()
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:GetFlagEffect(111011002)~=0
		and Duel.IsExistingMatchingCard(c111011002.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,rank,e,tp)
end
function c111011002.xyzfilter(c,rank,e,tp)
	return c:GetRank()==rank+1 and (c:IsSetCard(0x1048) or c:IsSetCard(0x1073) or c:IsCode(511000296))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c111011002.xyztg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c111011002.tgfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c111011002.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c111011002.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c111011002.xyzop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	local sg=Group.CreateGroup()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c111011002.xyzfilter,tp,LOCATION_EXTRA,0,1,1,nil,tc:GetRank(),e,tp)
	local sc=g:GetFirst()
	if sc then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(tc))
		Duel.Overlay(sc,Group.FromCards(tc))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
