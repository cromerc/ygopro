--Star Shift
function c511000865.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000865.target)
	e1:SetOperation(c511000865.activate)
	c:RegisterEffect(e1)
end
function c511000865.filter(c,e,tp)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c:IsAbleToExtra() and Duel.IsExistingMatchingCard(c511000865.spfilter,tp,LOCATION_EXTRA,0,1,nil,c:GetLevel(),c:GetCode(),e,tp)
end
function c511000865.spfilter(c,lv,code,e,tp)
	return c:IsType(TYPE_SYNCHRO) and c:GetLevel()==lv and c:GetCode()~=code and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000865.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000865.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000865.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c511000865.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c511000865.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	if Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511000865.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,tc:GetLevel(),tc:GetCode(),e,tp):GetFirst()
		if Duel.SpecialSummonStep(g,0,tp,tp,false,false,POS_FACEUP)~=0 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			g:RegisterEffect(e1,true)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			g:RegisterEffect(e2,true)
			Duel.SpecialSummonComplete()
		end
	end
end
