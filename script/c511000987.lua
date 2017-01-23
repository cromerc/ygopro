--融合解除
function c511000987.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000987.target)
	e1:SetOperation(c511000987.activate)
	c:RegisterEffect(e1)
end
function c511000987.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION) and (c:IsAbleToExtra() or c:IsAbleToGrave())
end
function c511000987.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000987.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000987.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511000987.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c511000987.mgfilter(c,e,tp,fusc)
	return not c:IsControler(tp) or not c:IsLocation(LOCATION_GRAVE)
		or bit.band(c:GetReason(),0x40008)~=0x40008 or c:GetReasonCard()~=fusc
		or not c:IsCanBeSpecialSummoned(e,0,tp,false,false) or c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511000987.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not (tc:IsRelateToEffect(e) and tc:IsFaceup()) then return end
	local mg=tc:GetMaterial()
	local sumable=true
	local sumtype=tc:GetSummonType()
	local op=0
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
	if tc:IsAbleToExtra() and tc:IsAbleToGrave() then
		op=Duel.SelectOption(tp,aux.Stringid(2407147,0),aux.Stringid(52823314,0))
	elseif tc:IsAbleToExtra() then
		Duel.SelectOption(tp,aux.Stringid(2407147,0))
		op=0
	else
		Duel.SelectOption(tp,aux.Stringid(52823314,0))
		op=1
	end
	local ch=0
	if op==0 then
		ch=Duel.SendtoGrave(tc,REASON_EFFECT)
	else
		ch=Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)
	end
	if ch==0 or bit.band(sumtype,SUMMON_TYPE_FUSION)~=SUMMON_TYPE_FUSION or mg:GetCount()==0
		or mg:GetCount()>Duel.GetLocationCount(tc:GetControler(),LOCATION_MZONE)
		or mg:IsExists(c511000987.mgfilter,1,nil,e,tc:GetControler(),tc) then
		sumable=false
	end
	if sumable then
		Duel.BreakEffect()
		Duel.SpecialSummon(mg,0,tc:GetControler(),tc:GetControler(),false,false,POS_FACEUP)
	end
end
