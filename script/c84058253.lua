--キメラテック・ランページ・ドラゴン
function c84058253.initial_effect(c)
	c:EnableReviveLimit()
	--fusion material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c84058253.fscon)
	e1:SetOperation(c84058253.fsop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c84058253.descon)
	e2:SetTarget(c84058253.destg)
	e2:SetOperation(c84058253.desop)
	c:RegisterEffect(e2)
	--extra attack
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c84058253.tgtg)
	e3:SetOperation(c84058253.tgop)
	c:RegisterEffect(e3)
end
function c84058253.ffilter(c)
	return c:IsFusionSetCard(0x1093) and not c:IsHasEffect(6205579)
end
function c84058253.check1(c,mg,chkf)
	return mg:IsExists(c84058253.check2,1,c,c,chkf)
end
function c84058253.check2(c,c2,chkf)
	local g=Group.FromCards(c,c2)
	if g:IsExists(aux.TuneMagFusFilter,1,nil,g,chkf) then return false end
	local g1=g:Filter(c84058253.ffilter,nil)
	if chkf~=PLAYER_NONE then
		return g1:FilterCount(aux.FConditionCheckF,nil,chkf)~=0 and g1:GetCount()>=2
	else return g1:GetCount()>=2 end
end
function c84058253.fscon(e,g,gc,chkf)
	if g==nil then return false end
	local chkf=bit.band(chkfnf,0xff)
	local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
	if gc then
		if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
		return c84058253.check1(gc,mg,chkf)
	end
	return mg:IsExists(c84058253.check1,1,nil,mg,chkf)
end
function c84058253.fsop(e,tp,eg,ep,ev,re,r,rp,gc,chkf)
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
		local g1=mg:FilterSelect(p,c84058253.check2,1,1,gc,gc,chkf)
		mg:Sub(g1)
		while mg:IsExists(Auxiliary.FConditionFilterExtraMaterial,1,nil,mg,c84058253.ffilter) and Duel.SelectYesNo(p,93) do
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
			local g2=mg:FilterSelect(p,Auxiliary.FConditionFilterExtraMaterial,1,1,nil,mg,c84058253.ffilter)
			g1:Merge(g2)
			mg:Sub(g2)
		end
		if sfhchk then Duel.ShuffleHand(tp) end
		Duel.SetFusionMaterial(g1)
		return
	end
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
	local g1=mg:FilterSelect(p,c84058253.check1,1,1,nil,mg,chkf)
	local tc1=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
	local g2=mg:FilterSelect(p,c84058253.check2,1,1,tc1,tc1,chkf)
	g1:Merge(g2)
	mg:Sub(g1)
	while mg:IsExists(Auxiliary.FConditionFilterExtraMaterial,1,nil,mg,c84058253.ffilter) and Duel.SelectYesNo(p,93) do
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
		local g3=mg:FilterSelect(p,Auxiliary.FConditionFilterExtraMaterial,1,1,nil,mg,c84058253.ffilter)
		g1:Merge(g3)
		mg:Sub(g3)
	end
	if sfhchk then Duel.ShuffleHand(tp) end
	Duel.SetFusionMaterial(g1)
end
function c84058253.descon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c84058253.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c84058253.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c84058253.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c84058253.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local ct=e:GetHandler():GetMaterialCount()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp, c84058253.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c84058253.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(g,REASON_EFFECT)
end
function c84058253.tgfilter(c)
	return c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToGrave()
end
function c84058253.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c84058253.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c84058253.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c84058253.tgfilter,tp,LOCATION_DECK,0,1,2,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoGrave(g,REASON_EFFECT)
	local c=e:GetHandler()
	local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)
	if ct>0 and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(ct)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
