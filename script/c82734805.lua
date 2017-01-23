--インフェルノイド・ティエラ
function c82734805.initial_effect(c)
	c:EnableReviveLimit()
	--fusion material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(c82734805.fscon)
	e1:SetOperation(c82734805.fsop)
	c:RegisterEffect(e1)
	--spsummon success
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(82734805,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c82734805.con)
	e2:SetTarget(c82734805.tg)
	e2:SetOperation(c82734805.op)
	c:RegisterEffect(e2)
	--material check
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_MATERIAL_CHECK)
	e3:SetValue(c82734805.valcheck)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
end
c82734805.material_count=2
c82734805.material={14799437,23440231}
function c82734805.valcheck(e,c)
	local ct=e:GetHandler():GetMaterial():GetClassCount(Card.GetCode)
	e:GetLabelObject():SetLabel(ct)
end
function c82734805.con(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c82734805.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=e:GetLabel()
	local con3,con5,con8,con10=nil
	if ct>=3 then
		con3=Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_EXTRA,0,3,nil)
			and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,0,LOCATION_EXTRA,3,nil)
	end
	if ct>=5 then
		con5=Duel.IsPlayerCanDiscardDeck(tp,3) and Duel.IsPlayerCanDiscardDeck(1-tp,3)
	end
	if ct>=8 then
		con8=Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_REMOVED,0,1,nil)
			and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_REMOVED,1,nil)
	end
	if ct>=10 then
		con10=Duel.GetFieldGroupCount(tp,LOCATION_HAND,LOCATION_HAND)>0
	end
	if chk==0 then return con3 or con5 or con8 or con10 end
end
function c82734805.op(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	if ct>=3 then
		local g1=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,LOCATION_EXTRA,0,nil)
		local sg1=nil
		if g1:GetCount()>=3 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			sg1=g1:Select(tp,3,3,nil)
		else sg1=g1 end
		local g2=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,0,LOCATION_EXTRA,nil)
		local sg2=nil
		if g2:GetCount()>=3 then
			Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
			sg2=g2:Select(1-tp,3,3,nil)
		else sg2=g2 end
		sg1:Merge(sg2)
		if sg1:GetCount()>0 then
			Duel.SendtoGrave(sg1,REASON_EFFECT)
		end
	end
	if ct>=5 then
		Duel.BreakEffect()
		Duel.DiscardDeck(tp,3,REASON_EFFECT)
		Duel.DiscardDeck(1-tp,3,REASON_EFFECT)
	end
	if ct>=8 then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g1=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_REMOVED,0,1,3,nil)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
		local g2=Duel.SelectMatchingCard(1-tp,Card.IsFaceup,1-tp,LOCATION_REMOVED,0,1,3,nil)
		g1:Merge(g2)
		if g1:GetCount()>0 then
			Duel.SendtoGrave(g1,REASON_EFFECT+REASON_RETURN)
		end
	end
	if ct>=10 then
		Duel.BreakEffect()
		local g1=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
		Duel.SendtoGrave(g1,REASON_EFFECT)
	end
end
function c82734805.matfilter1(c,code,fc)
	return c:IsFusionCode(code) or c:CheckFusionSubstitute(fc)
end
function c82734805.matfilter2(c)
	return (c:IsFusionSetCard(0xbb) or c:IsHasEffect(511002961)) and not c:IsHasEffect(6205579)
end
function c82734805.filterchk1(c,mg,matg,chkf,fc,gc1,gc2,gc3)
	local tg=Group.CreateGroup()
	local g=mg:Clone()
	if gc1 and c~=gc1 then return false end
	if not c82734805.matfilter1(c,14799437,fc) then return false end
	tg:AddCard(c)
	g:RemoveCard(c)
	return g:IsExists(c82734805.filterchk2,1,nil,g,tg,chkf,c,fc,gc2,gc3)
end
function c82734805.filterchk2(c,mg,matg,chkf,fc,sc,gc2,gc3)
	local tg=matg:Clone()
	local g=mg:Clone()
	if gc2 and c~=gc2 then return false end
	if sc:IsHasEffect(511002961) then
		if not c82734805.matfilter1(c,14799437,fc) and not c82734805.matfilter1(c,23440231,fc) then return false end
	elseif sc:CheckFusionSubstitute(fc) and not sc:IsFusionCode(14799437,23440231) then
		if not c:IsFusionCode(14799437,23440231) then return false end
	else
		if sc:CheckFusionSubstitute(fc) and sc:IsFusionCode(14799437) then
			if not c:IsFusionCode(23440231) and not c:CheckFusionSubstitute(fc) then return false end
		elseif sc:CheckFusionSubstitute(fc) and sc:IsFusionCode(23440231) then
			if not c:IsFusionCode(14799437) and not c:CheckFusionSubstitute(fc) then return false end
		elseif sc:CheckFusionSubstitute(fc) then
			if c:CheckFusionSubstitute(fc) and not c:IsFusionCode(14799437,23440231) then return false end
		else
			if not c82734805.matfilter1(c,23440231,fc) then return false end
		end
	end
	tg:AddCard(c)
	g:RemoveCard(c)
	return g:IsExists(c82734805.filterchk3,1,nil,tg,chkf,gc3)
end
function c82734805.filterchk3(c,matg,chkf,gc3)
	local g=matg:Clone()
	if gc3 and c~=gc3 then return false end
	if not c82734805.matfilter2(c) then return false end
	g:AddCard(c)
	if g:IsExists(aux.TuneMagFusFilter,1,nil,g,chkf) then return false end
	return g:IsExists(aux.FConditionCheckF,1,nil,chkf) or chkf==PLAYER_NONE
end
function c82734805.fscon(e,g,gc,chkf)
	if g==nil then return true end
	local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
	if gc then
		if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
		mg:AddCard(gc)
		return mg:IsExists(c82734805.filterchk1,1,nil,mg,nil,chkf,e:GetHandler(),gc,nil,nil) 
			or mg:IsExists(c82734805.filterchk1,1,nil,mg,nil,chkf,e:GetHandler(),nil,gc,nil) 
			or mg:IsExists(c82734805.filterchk1,1,nil,mg,nil,chkf,e:GetHandler(),nil,nil,gc) 
	end
	return mg:IsExists(c82734805.filterchk1,1,nil,mg,nil,chkf,e:GetHandler()) 
end
function c82734805.extramaterial(c,mg,chkf,eff)
	local g=mg:Clone()
	g:AddCard(c)
	if g:IsExists(aux.TuneMagFusFilter,1,nil,g,chkf) then return false end
	return c82734805.matfilter2(c) and (not c:IsLocation(LOCATION_DECK) or not eff or g:FilterCount(Card.IsLocation,nil,LOCATION_DECK)<=6)
end
function c82734805.fsop(e,tp,eg,ep,ev,re,r,rp,gc,chkf)
	local g=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
	local p=tp
	local sfhchk=false
	if Duel.IsPlayerAffectedByEffect(tp,511004008) and Duel.SelectYesNo(1-tp,65) then
		p=1-tp Duel.ConfirmCards(1-tp,g)
		if g:IsExists(Card.IsLocation,1,nil,LOCATION_HAND) then sfhchk=true end
	end
	if gc then
		g:AddCard(gc)
		if g:IsExists(c82734805.filterchk1,1,nil,g,nil,chkf,e:GetHandler(),gc,nil,nil) then
			local matg=Group.FromCards(gc)
			g:Sub(matg)
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
			local g1=g:FilterSelect(p,c82734805.filterchk2,1,1,nil,g,matg,chkf,e:GetHandler(),gc,nil,nil)
			matg:Merge(g1)
			g:Sub(g1)
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
			local g2=g:FilterSelect(p,c82734805.filterchk3,1,1,nil,matg,chkf)
			matg:Merge(g2)
			g:Sub(g2)
			while g:IsExists(c82734805.extramaterial,1,nil,matg,chkf,e:GetHandler():GetFlagEffect(31444249)~=0) and Duel.SelectYesNo(p,93) do
				Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
				local g3=g:FilterSelect(p,c82734805.extramaterial,1,1,nil,matg,chkf,e:GetHandler():GetFlagEffect(31444249)~=0)
				matg:Merge(g3)
				g:Sub(g3)
			end
			if sfhchk then Duel.ShuffleHand(tp) end
			matg:RemoveCard(gc)
			Duel.SetFusionMaterial(matg)
		elseif g:IsExists(c82734805.filterchk1,1,nil,g,nil,chkf,e:GetHandler(),nil,gc,nil) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
			local matg=g:FilterSelect(tp,c82734805.filterchk1,1,1,nil,g,matg,chkf,e:GetHandler(),nil,gc,nil)
			matg:AddCard(gc)
			g:RemoveCard(gc)
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
			local g2=g:FilterSelect(p,c82734805.filterchk3,1,1,nil,matg,chkf)
			matg:Merge(g2)
			g:Sub(g2)
			while g:IsExists(c82734805.extramaterial,1,nil,matg,chkf,e:GetHandler():GetFlagEffect(31444249)~=0) and Duel.SelectYesNo(p,93) do
				Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
				local g3=g:FilterSelect(p,c82734805.extramaterial,1,1,nil,matg,chkf,e:GetHandler():GetFlagEffect(31444249)~=0)
				matg:Merge(g3)
				g:Sub(g3)
			end
			if sfhchk then Duel.ShuffleHand(tp) end
			matg:RemoveCard(gc)
			Duel.SetFusionMaterial(matg)
		else
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
			local matg=g:FilterSelect(tp,c82734805.filterchk1,1,1,nil,g,matg,chkf,e:GetHandler(),nil,nil,gc)
			g:Sub(matg)
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
			local g1=g:FilterSelect(p,c82734805.filterchk2,1,1,nil,g,matg,chkf,e:GetHandler(),matg:GetFirst(),nil,gc)
			matg:Merge(g1)
			g:Sub(g1)
			matg:AddCard(gc)
			g:RemoveCard(gc)
			while g:IsExists(c82734805.extramaterial,1,nil,matg,chkf,e:GetHandler():GetFlagEffect(31444249)~=0) and Duel.SelectYesNo(p,93) do
				Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
				local g3=g:FilterSelect(p,c82734805.extramaterial,1,1,nil,matg,chkf,e:GetHandler():GetFlagEffect(31444249)~=0)
				matg:Merge(g3)
				g:Sub(g3)
			end
			if sfhchk then Duel.ShuffleHand(tp) end
			matg:RemoveCard(gc)
			Duel.SetFusionMaterial(matg)
		end
		return
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local matg=g:FilterSelect(tp,c82734805.filterchk1,1,1,nil,g,matg,chkf,e:GetHandler(),nil,nil,gc)
	g:Sub(matg)
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
	local g1=g:FilterSelect(p,c82734805.filterchk2,1,1,nil,g,matg,chkf,e:GetHandler(),matg:GetFirst(),nil,gc)
	matg:Merge(g1)
	g:Sub(g1)
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
	local g2=g:FilterSelect(p,c82734805.filterchk3,1,1,nil,matg,chkf)
	matg:Merge(g2)
	g:Sub(g2)
	while g:IsExists(c82734805.extramaterial,1,nil,matg,chkf,e:GetHandler():GetFlagEffect(31444249)~=0) and Duel.SelectYesNo(p,93) do
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
		local g3=g:FilterSelect(p,c82734805.extramaterial,1,1,nil,matg,chkf,e:GetHandler():GetFlagEffect(31444249)~=0)
		matg:Merge(g3)
		g:Sub(g3)
	end
	Duel.SetFusionMaterial(matg)
	return
end
