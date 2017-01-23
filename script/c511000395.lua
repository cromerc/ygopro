--Cold Fusion
function c511000395.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000395.target)
	e1:SetOperation(c511000395.activate)
	c:RegisterEffect(e1)
end
function c511000395.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION) and c:IsDestructable()
end
function c511000395.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000395.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000395.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c511000395.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511000395.mgfilter(c,e,tp,fusc)
	return not c:IsControler(1-tp) or not c:IsLocation(LOCATION_GRAVE)
		or bit.band(c:GetReason(),0x40008)~=0x40008 or c:GetReasonCard()~=fusc
		or not c:IsCanBeSpecialSummoned(e,0,1-tp,false,false) or c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511000395.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not (tc:IsRelateToEffect(e) and tc:IsFaceup()) then return end
	local mg=tc:GetMaterial()
	local sumable=true
	local sumtype=tc:GetSummonType()
	if Duel.Destroy(tc,REASON_EFFECT)==0 or bit.band(sumtype,SUMMON_TYPE_FUSION)~=SUMMON_TYPE_FUSION or mg:GetCount()==0
		or mg:GetCount()>Duel.GetLocationCount(tp,LOCATION_MZONE)
		or mg:IsExists(c511000395.mgfilter,1,nil,e,tp,tc) then
		sumable=false
	end
	if sumable then
		Duel.BreakEffect()
		local mgs=mg:GetFirst()
		while mgs do
			Duel.SpecialSummonStep(mgs,0,1-tp,1-tp,false,false,POS_FACEUP)
			mgs:AddCounter(0x1015,1)
			mgs=mg:GetNext()
		end
		Duel.SpecialSummonComplete()
		local g=Duel.GetMatchingGroup(c511000395.tg,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		local tg=g:GetFirst()
		while tg do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tg:RegisterEffect(e1)
			tg=g:GetNext()
		end
	end
end
function c511000395.tg(c)
	return c:GetCounter(0x1015)~=0
end