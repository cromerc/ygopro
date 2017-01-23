--Choshobu
function c511002476.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002476.target)
	e1:SetOperation(c511002476.activate)
	c:RegisterEffect(e1)
end
function c511002476.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c:IsAbleToExtra()
end
function c511002476.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511002476.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002476.filter,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.IsPlayerCanDraw(tp,1) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c511002476.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c511002476.mgfilter(c,e,tp,sync)
	return not c:IsControler(tp) or not c:IsLocation(LOCATION_GRAVE)
		or bit.band(c:GetReason(),0x80008)~=0x80008 or c:GetReasonCard()~=sync
		or not c:IsCanBeSpecialSummoned(e,0,tp,false,false) or c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511002476.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	local mg=tc:GetMaterial()
	local sumable=true
	local sumtype=tc:GetSummonType()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)==0 or sumtype~=SUMMON_TYPE_SYNCHRO or mg:GetCount()==0 
		or mg:GetCount()>ft
		or mg:IsExists(c511002476.mgfilter,1,nil,e,tp,tc) then
		sumable=false
	end
	if sumable and Duel.SelectYesNo(tp,aux.Stringid(32441317,0)) then
		Duel.BreakEffect()
		local spc=mg:GetFirst()
		while spc do
			Duel.SpecialSummonStep(spc,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL)
			e1:SetValue(2)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			spc:RegisterEffect(e1,true)
			spc=mg:GetNext()
		end
		Duel.SpecialSummonComplete()
		Duel.BreakEffect()
		local hc=Duel.GetDecktopGroup(tp,1):GetFirst()
		Duel.Draw(tp,1,REASON_EFFECT)
		if hc then
			Duel.ConfirmCards(1-tp,hc)
			if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and hc:IsSetCard(0xe3) then
				Duel.SpecialSummonStep(hc,0,tp,tp,true,false,POS_FACEUP)
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_CHANGE_LEVEL)
				e1:SetValue(2)
				e1:SetReset(RESET_EVENT+0x1fe0000)
				hc:RegisterEffect(e1,true)
				Duel.SpecialSummonComplete()
			elseif hc:IsType(TYPE_MONSTER) then
				local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
				if Duel.Destroy(sg,REASON_EFFECT)>0 then
					local lp=Duel.GetLP(tp)
					Duel.SetLP(tp,math.ceil(lp/2))
				end
			end
			Duel.ShuffleHand(tp)
		end
	end
end
