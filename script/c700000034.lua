--Scripted by Eerie Code
--Ancient Gear Chaos Fusion
--fixed by MLD
function c700000034.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetCost(c700000034.cost)
	e1:SetTarget(c700000034.target)
	e1:SetOperation(c700000034.activate)
	c:RegisterEffect(e1)
end
function c700000034.cfilter(c)
	return c:IsCode(24094653) and c:IsAbleToGraveAsCost()
end
function c700000034.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c700000034.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c700000034.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c700000034.matfilter(c,e,tp)
	return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e) and c:IsCanBeSpecialSummoned(e,0,tp,true,false) 
end
function c700000034.spfilter(c,e,tp)
	if not c:IsType(TYPE_FUSION) or not c:IsSetCard(0x7) or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) then return false end
	local ct=c.material_count
	if not ct or Duel.GetLocationCount(tp,LOCATION_MZONE)<ct then return false end
	local mg=Duel.GetMatchingGroup(c700000034.matfilter,tp,LOCATION_DECK+LOCATION_EXTRA+LOCATION_GRAVE,0,nil,e,tp)
	local rg=Duel.GetMatchingGroup(c700000034.rmfilter,tp,LOCATION_GRAVE,0,nil)
	return rg:IsExists(c700000034.rmfilter2,1,nil,mg,rg,ct,c)
end
function c700000034.rmfilter(c)
	return c:GetSummonLocation()==LOCATION_EXTRA and c:IsPreviousLocation(LOCATION_MZONE) and c:IsAbleToRemove()
end
function c700000034.rmfilter2(c,g,rg,ct,fc)
	local mg=g:Clone()
	local rg2=rg:Clone()
	if mg:IsContains(c) then mg:RemoveCard(c) end
	rg2:RemoveCard(c)
	ct=ct-1
	if ct>0 then
		return fc:CheckFusionMaterial(mg,nil) and rg2:IsExists(c700000034.rmfilter2,1,nil,mg,rg2,ct,fc)
	else
		return fc:CheckFusionMaterial(mg,nil)
	end
end
function c700000034.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSpecialSummonCount(tp,2) 
		and Duel.IsExistingMatchingCard(c700000034.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local fg=Duel.SelectMatchingCard(tp,c700000034.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	Duel.ConfirmCards(1-tp,fg:GetFirst())
	Duel.SetTargetCard(fg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c700000034.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not c700000034.spfilter(tc,e,tp) then return false end
	local ct=tc.material_count
	local mg=Duel.GetMatchingGroup(c700000034.matfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,nil,e,tp)
	local rg=Duel.GetMatchingGroup(c700000034.rmfilter,tp,LOCATION_GRAVE,0,nil)
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local sg=Group.CreateGroup()
	local mg2=Duel.GetMatchingGroup(c700000034.matfilter,tp,LOCATION_GRAVE,0,nil,e,tp)
	if tc:CheckFusionMaterial(mg,nil) and rg:GetCount()>=ct then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		sg=rg:Select(tp,ct,ct,nil)
	else
		mg:Merge(mg2)
		mg:Sub(rg)
		if tc:CheckFusionMaterial(mg,nil) and rg:GetCount()>=ct then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
			sg=rg:Select(tp,ct,ct,nil)
		else
			mg:Merge(mg2)
			rg:Sub(mg)
			if tc:CheckFusionMaterial(mg,nil) and rg:GetCount()>=ct then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
				sg=rg:Select(tp,ct,ct,nil)
			else
				local g=mg:Clone()
				repeat
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
					local sc=rg:FilterSelect(tp,c700000034.rmfilter2,1,1,nil,g,rg,ct,tc):GetFirst()
					rg:RemoveCard(sc)
					sg:AddCard(sc)
					ct=ct-1
				until ct<=0
			end
		end
	end
	mg:Sub(sg)
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	local mat=Duel.SelectFusionMaterial(tp,tc,mg,nil,chkf)
	local mc=mat:GetFirst()
	while mc do
		Duel.SpecialSummonStep(mc,0,tp,tp,true,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		mc:RegisterEffect(e1)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_DISABLE_EFFECT)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		mc:RegisterEffect(e3)
		mc=mat:GetNext()
	end
	Duel.SpecialSummonComplete()
	Duel.BreakEffect()
	tc:SetMaterial(mat)
	Duel.SendtoGrave(mat,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
	Duel.BreakEffect()
	Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
end
