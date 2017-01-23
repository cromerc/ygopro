--RUM－七皇の剣
function c513000008.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c513000008.target)
	e1:SetOperation(c513000008.activate)
	c:RegisterEffect(e1)
end
function c513000008.filter1(c,e,tp)
	local m=_G["c"..c:GetCode()]
	if not m then return false end
	local no=m.xyz_number
	local rk=c:GetRank()
	if not no or no<101 or no>107 or not c:IsSetCard(0x48) or rk<=0 then return false end
	if c:IsLocation(LOCATION_GRAVE+LOCATION_EXTRA) then
		return c:IsCanBeSpecialSummoned(e,0,tp,true,false) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	else
		return c:IsFaceup() and Duel.IsExistingMatchingCard(c513000008.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,rk)
	end
		
end
function c513000008.filter2(c,e,tp,mc,rk)
	return (c:IsSetCard(0x1048) or c:IsSetCard(0x1073) or c:IsCode(511000296)) and mc:IsCanBeXyzMaterial(c) 
		and c:GetRank()==rk+1 and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c513000008.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c513000008.filter1,tp,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c513000008.filter1,tp,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetFirst():IsLocation(LOCATION_MZONE) then
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	else
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_EXTRA)
	end
end
function c513000008.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local reqxyz=false
	if not tc then return end
	if tc:IsLocation(LOCATION_MZONE) then
		if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
		reqxyz=true
	else
		if not tc:IsRelateToEffect(e) or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 
			or tc:IsHasEffect(EFFECT_NECRO_VALLEY) then return end
		if Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP)then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e2)
			Duel.SpecialSummonComplete()
		end
	end
	local sg=Duel.GetMatchingGroup(c513000008.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,tc,tc:GetRank())
	if sg:GetCount()>0 and (reqxyz or Duel.SelectYesNo(tp,aux.Stringid(73988674,2))) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sc=sg:Select(tp,1,1,nil):GetFirst()
		if sc then
			local mg=tc:GetOverlayGroup()
			if mg:GetCount()~=0 then
				Duel.Overlay(sc,mg)
			end
			mg:AddCard(tc)
			sc:SetMaterial(mg)
			Duel.Overlay(sc,Group.FromCards(tc))
			Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
			sc:CompleteProcedure()
		end
	end
end
