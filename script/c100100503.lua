--Ｓｐ－融合解除
function c100100503.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100100503.target)
	e1:SetOperation(c100100503.activate)
	c:RegisterEffect(e1)
end
function c100100503.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION) and c:IsAbleToExtra()
end
function c100100503.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local td=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c100100503.filter(chk) end
	if chk==0 then return Duel.IsExistingTarget(c100100503.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) 
		and td and td:GetCounter(0x91)>1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c100100503.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c100100503.mgfilter(c,e,tp,fusc)
	return not c:IsControler(tp) or not c:IsLocation(LOCATION_GRAVE)
		or bit.band(c:GetReason(),0x40008)~=0x40008 or c:GetReasonCard()~=fusc
		or not c:IsCanBeSpecialSummoned(e,0,tp,false,false) or c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c100100503.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local mg=tc:GetMaterial()
	local sumable=true
	local sumtype=tc:GetSummonType()
	if Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)==0 or bit.band(sumtype,SUMMON_TYPE_FUSION)~=SUMMON_TYPE_FUSION or mg:GetCount()==0
		or mg:GetCount()>Duel.GetLocationCount(tp,LOCATION_MZONE)
		or mg:IsExists(c100100503.mgfilter,1,nil,e,tp,tc) then
		sumable=false
	end
	if sumable and Duel.SelectYesNo(tp,aux.Stringid(100100503,0)) then
		Duel.BreakEffect()
		Duel.SpecialSummon(mg,0,tp,tp,false,false,POS_FACEUP)
	end
end
