--ワーム・ゼロ
function c74506079.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c74506079.fscon)
	e1:SetOperation(c74506079.fsop)
	c:RegisterEffect(e1)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c74506079.matcheck)
	c:RegisterEffect(e2)
end
function c74506079.ffilter(c)
	if c:IsHasEffect(6205579) then return false end
	return (c:IsFusionSetCard(0x3e) and c:IsRace(RACE_REPTILE)) or c:IsHasEffect(511002961)
end
function c74506079.check1(c,mg,chkf)
	return mg:IsExists(c74506079.check2,1,c,c,chkf)
end
function c74506079.check2(c,c2,chkf)
	local g=Group.FromCards(c,c2)
	if g:IsExists(aux.TuneMagFusFilter,1,nil,g,chkf) then return false end
	local g1=g:Filter(c74506079.ffilter,nil)
	if chkf~=PLAYER_NONE then
		return g1:FilterCount(aux.FConditionCheckF,nil,chkf)~=0 and g1:GetCount()>=2
	else return g1:GetCount()>=2 end
end
function c74506079.fscon(e,g,gc,chkfnf)
	if g==nil then return true end
	local chkf=bit.band(chkfnf,0xff)
	local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
	if gc then
		if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
		return c74506079.check1(gc,mg,chkf)
	end
	return mg:IsExists(c74506079.check1,1,nil,mg,chkf)
end
function c74506079.fsop(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
	local chkf=bit.band(chkfnf,0xff)
	local mg=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
	local p=tp
	local sfhchk=false
	if Duel.IsPlayerAffectedByEffect(tp,511004008) and Duel.SelectYesNo(1-tp,65) then
		p=1-tp Duel.ConfirmCards(1-tp,g)
		if mg:IsExists(Card.IsLocation,1,nil,LOCATION_HAND) then sfhchk=true end
	end
	if gc then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
		local g1=mg:FilterSelect(p,c74506079.check2,1,1,gc,gc,chkf)
		mg:Sub(g1)
		while mg:IsExists(Auxiliary.FConditionFilterExtraMaterial,1,nil,mg,c74506079.ffilter) and Duel.SelectYesNo(p,93) do
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
			local g2=mg:FilterSelect(p,Auxiliary.FConditionFilterExtraMaterial,1,1,nil,mg,c74506079.ffilter)
			g1:Merge(g2)
			mg:Sub(g2)
		end
		if sfhchk then Duel.ShuffleHand(tp) end
		Duel.SetFusionMaterial(g1)
		return
	end
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
	local g1=mg:FilterSelect(p,c74506079.check1,1,1,nil,mg,chkf)
	local tc1=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
	local g2=mg:FilterSelect(p,c74506079.check2,1,1,tc1,tc1,chkf)
	g1:Merge(g2)
	mg:Sub(g1)
	while mg:IsExists(aux.FConditionFilterExtraMaterial,1,nil,mg,c74506079.ffilter) and Duel.SelectYesNo(p,93) do
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
		local g3=mg:FilterSelect(p,aux.FConditionFilterExtraMaterial,1,1,nil,mg,c74506079.ffilter)
		g1:Merge(g3)
		mg:Sub(g3)
	end
	if sfhchk then Duel.ShuffleHand(tp) end
	Duel.SetFusionMaterial(g1)
end
function c74506079.matcheck(e,c)
	local ct=c:GetMaterial():GetClassCount(Card.GetCode)
	if ct>0 then
		local ae=Effect.CreateEffect(c)
		ae:SetType(EFFECT_TYPE_SINGLE)	
		ae:SetCode(EFFECT_SET_ATTACK)
		ae:SetValue(ct*500)
		ae:SetReset(RESET_EVENT+0xff0000)
		c:RegisterEffect(ae)
	end
	if ct>=2 then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(74506079,0))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_IGNITION)
		e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCountLimit(1)
		e1:SetTarget(c74506079.sptg)
		e1:SetOperation(c74506079.spop)
		e1:SetReset(RESET_EVENT+0xfe0000)
		c:RegisterEffect(e1)
	end
	if ct>=4 then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(74506079,1))
		e1:SetCategory(CATEGORY_TOGRAVE)
		e1:SetType(EFFECT_TYPE_IGNITION)
		e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCost(c74506079.tgcost)
		e1:SetTarget(c74506079.tgtg)
		e1:SetOperation(c74506079.tgop)
		e1:SetReset(RESET_EVENT+0xfe0000)
		c:RegisterEffect(e1)
	end
	if ct>=6 then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(74506079,2))
		e1:SetCategory(CATEGORY_DRAW)
		e1:SetType(EFFECT_TYPE_IGNITION)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCountLimit(1)
		e1:SetTarget(c74506079.drtg)
		e1:SetOperation(c74506079.drop)
		e1:SetReset(RESET_EVENT+0xfe0000)
		c:RegisterEffect(e1)
	end
end
function c74506079.spfilter(c,e,tp)
	return c:IsRace(RACE_REPTILE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
end
function c74506079.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c74506079.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c74506079.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c74506079.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c74506079.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
		Duel.ConfirmCards(1-tp,tc)
	end
end
function c74506079.costfilter(c)
	return c:IsRace(RACE_REPTILE) and c:IsAbleToRemoveAsCost()
end
function c74506079.tgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c74506079.costfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=Duel.SelectMatchingCard(tp,c74506079.costfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c74506079.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c74506079.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end
function c74506079.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c74506079.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
