--メタルフォーゼ・アダマンテ
function c81612598.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c81612598.fscon)
	e1:SetOperation(c81612598.fsop)
	c:RegisterEffect(e1)
end
function c81612598.filter1(c)
	return (c:IsFusionSetCard(0xe1) or c:IsHasEffect(511002961)) and not c:IsHasEffect(6205579)
end
function c81612598.filter2(c)
	return (c:IsAttackBelow(2500) or c:IsHasEffect(511002961)) and not c:IsHasEffect(6205579)
end
function c81612598.fscon(e,g,gc,chkfnf)
	if g==nil then return true end
	local f1=c81612598.filter1
	local f2=c81612598.filter2
	local chkf=bit.band(chkfnf,0xff)
	local tp=e:GetHandlerPlayer()
	local fg=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_MZONE,0,nil,77693536)
	local fc=fg:GetFirst()
	while fc do
		g:Merge(fc:GetEquipGroup():Filter(Card.IsControler,nil,tp))
		fc=fg:GetNext()
	end
	local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler(),true)
	if gc then
		if not gc:IsCanBeFusionMaterial(e:GetHandler(),true) then return false end
		return aux.FConditionFilterF2(gc,f1,f2,mg,chkf)
	end
	return mg:IsExists(aux.FConditionFilterF2,1,nil,f1,f2,mg,chkf)
end
function c81612598.fsop(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
	local f1=c81612598.filter1
	local f2=c81612598.filter2
	local chkf=bit.band(chkfnf,0xff)
	local fg=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_MZONE,0,nil,77693536)
	local fc=fg:GetFirst()
	while fc do
		eg:Merge(fc:GetEquipGroup():Filter(Card.IsControler,nil,tp))
		fc=fg:GetNext()
	end
	local g=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler(),true)
	local p=tp
	local sfhchk=false
	if Duel.IsPlayerAffectedByEffect(tp,511004008) and Duel.SelectYesNo(1-tp,65) then
		p=1-tp Duel.ConfirmCards(1-tp,g)
		if g:IsExists(Card.IsLocation,1,nil,LOCATION_HAND) then sfhchk=true end
	end
	if gc then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
		local g1=g:FilterSelect(p,aux.FConditionFilterF2chk,1,1,gc,f1,f2,gc,chkf)
		if sfhchk then Duel.ShuffleHand(tp) end
		Duel.SetFusionMaterial(g1)
		return
	end
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
	local g1=g:FilterSelect(p,aux.FConditionFilterF2,1,1,nil,f1,f2,g,chkf)
	local tc1=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
	local g2=g:FilterSelect(p,aux.FConditionFilterF2chk,1,1,tc1,f1,f2,tc1,chkf)
	g1:Merge(g2)
	if sfhchk then Duel.ShuffleHand(tp) end
	Duel.SetFusionMaterial(g1)
end
