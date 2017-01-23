--Barrier Ninjitsu Art of Hazy Transfer
function c511002653.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511002653.target)
	e1:SetOperation(c511002653.activate)
	c:RegisterEffect(e1)
end
function c511002653.filter(c,tp)
	return c:IsFaceup() and Duel.IsExistingMatchingCard(c511002653.efffilter,tp,0,LOCATION_MZONE,1,c)
end
function c511002653.efffilter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function c511002653.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511002653.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511002653.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511002653.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
end
function c511002653.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local g=Duel.SelectMatchingCard(tp,c511002653.efffilter,tp,0,LOCATION_MZONE,1,1,tc)
		local tc2=g:GetFirst()
		if tc2 then
			Duel.HintSelection(g)
			tc:CopyEffect(tc2:GetOriginalCode(),RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,1)
			if not tc:IsType(TYPE_EFFECT) then
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_ADD_TYPE)
				e1:SetValue(TYPE_EFFECT)
				e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
				tc:RegisterEffect(e1)
			end
		end
	end
end
