--メタルフォーゼ・カーディナル
function c54401832.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c54401832.fscon)
	e1:SetOperation(c54401832.fsop)
	c:RegisterEffect(e1)
end
function c54401832.filter1(c)
	return (c:IsFusionSetCard(0xe1) or c:IsHasEffect(511002961)) and not c:IsHasEffect(6205579)
end
function c54401832.filter2(c)
	return (c:IsAttackBelow(3000) or c:IsHasEffect(511002961)) and not c:IsHasEffect(6205579)
end
function c54401832.fscon(e,g,gc,chkfnf)
	if g==nil then return true end
	local f1=c54401832.filter1
	local f2=c54401832.filter2
	local chkf=bit.band(chkfnf,0xff)
	local tp=e:GetHandlerPlayer()
	local fg=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_MZONE,0,nil,77693536)
	local fc=fg:GetFirst()
	while fc do
		g:Merge(fc:GetEquipGroup():Filter(Card.IsControler,nil,tp))
		fc=fg:GetNext()
	end
	local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler(),true)
	local mg1=mg:Filter(aux.FConditionFilterConAndSub,nil,f1,true)
	if gc then
		if not gc:IsCanBeFusionMaterial(e:GetHandler(),true) then return false end
		return aux.FConditionFilterFFRCol1(gc,f1,f2,2,chkf,mg,nil,0) 
			or mg1:IsExists(aux.FConditionFilterFFRCol1,1,nil,f1,f2,2,chkf,mg,nil,0,gc)
	end
	return mg1:IsExists(Auxiliary.FConditionFilterFFRCol1,1,nil,f1,f2,2,chkf,mg,nil,0)
end
function c54401832.fsop(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
	local f1=c54401832.filter1
	local f2=c54401832.filter2
	local chkf=bit.band(chkfnf,0xff)
	local fg=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_MZONE,0,nil,77693536)
	local fc=fg:GetFirst()
	while fc do
		eg:Merge(fc:GetEquipGroup():Filter(Card.IsControler,nil,tp))
		fc=fg:GetNext()
	end
	local g=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler(),true)
	local mg1=g:Filter(aux.FConditionFilterConAndSub,nil,f1,true)
	local p=tp
	local sfhchk=false
	if Duel.IsPlayerAffectedByEffect(tp,511004008) and Duel.SelectYesNo(1-tp,65) then
		p=1-tp Duel.ConfirmCards(1-tp,g)
		if g:IsExists(Card.IsLocation,1,nil,LOCATION_HAND) then sfhchk=true end
	end
	if gc then
		local matg=Group.CreateGroup()
		if aux.FConditionFilterFFRCol1(gc,f1,f2,2,chkf,g,nil,0) then
			matg:AddCard(gc)
			for i=1,2 do
				Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
				local g1=g:FilterSelect(p,aux.FConditionFilterFFRCol2,1,1,nil,f1,f2,2,chkf,g,matg,i-1)
				matg:Merge(g1)
				g:Sub(g1)
			end
			matg:RemoveCard(gc)
			if sfhchk then Duel.ShuffleHand(tp) end
			Duel.SetFusionMaterial(matg)
		else
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
			local matg=mg1:FilterSelect(p,aux.FConditionFilterFFRCol1,1,1,nil,f1,f2,2,chkf,g,nil,0,gc)
			matg:AddCard(gc)
			g:Sub(matg)
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
			local g1=g:FilterSelect(p,aux.FConditionFilterFFRCol2,1,1,nil,f1,f2,2,chkf,g,matg,1)
			matg:Merge(g1)
			g:Sub(g1)
			matg:RemoveCard(gc)
			if sfhchk then Duel.ShuffleHand(tp) end
			Duel.SetFusionMaterial(matg)
		end
		return
	end
	local matg=Group.CreateGroup()
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
	local matg=mg1:FilterSelect(p,aux.FConditionFilterFFRCol1,1,1,nil,f1,f2,2,chkf,g,nil,0,gc)
	g:Sub(matg)
	for i=1,2 do
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
		local g1=g:FilterSelect(p,aux.FConditionFilterFFRCol2,1,1,nil,f1,f2,2,chkf,g,matg,i-1)
		matg:Merge(g1)
		g:Sub(g1)
	end
	if sfhchk then Duel.ShuffleHand(tp) end
	Duel.SetFusionMaterial(matg)
end
