--フルメタルフォーゼ・アルカエスト
function c77693536.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_FUSION_MATERIAL)
	e0:SetCondition(c77693536.fscon)
	e0:SetOperation(c77693536.fsop)
	c:RegisterEffect(e0)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(77693536,0))
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetHintTiming(0,0x1e0)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c77693536.eqcon)
	e2:SetTarget(c77693536.eqtg)
	e2:SetOperation(c77693536.eqop)
	c:RegisterEffect(e2)
	--equip fusion material
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(77693536)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e3)
end
function c77693536.filter1(c)
	return (c:IsFusionSetCard(0xe1) or c:IsHasEffect(511002961)) and not c:IsHasEffect(6205579)
end
function c77693536.filter2(c)
	return (c:IsType(TYPE_NORMAL) or c:IsHasEffect(511002961)) and not c:IsHasEffect(6205579)
end
function c77693536.fscon(e,g,gc,chkfnf)
	if g==nil then return true end
	local f1=c77693536.filter1
	local f2=c77693536.filter2
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
function c77693536.fsop(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
	local f1=c77693536.filter1
	local f2=c77693536.filter2
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
function c77693536.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c77693536.eqfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
		and (c:IsControler(tp) or c:IsAbleToChangeControler())
end
function c77693536.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c77693536.eqfilter(chkc,tp) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c77693536.eqfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler(),tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c77693536.eqfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler(),tp)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c77693536.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not (tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsType(TYPE_EFFECT)) then return end
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local atk=tc:GetTextAttack()
		if atk<0 then atk=0 end
		if Duel.Equip(tp,tc,c)==0 then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_EQUIP_LIMIT)
		e2:SetValue(c77693536.eqlimit)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
	else Duel.SendtoGrave(tc,REASON_EFFECT) end
end
function c77693536.eqlimit(e,c)
	return e:GetOwner()==c
end
