--Forced Release
function c511001768.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001768.target)
	e1:SetOperation(c511001768.activate)
	c:RegisterEffect(e1)
end
function c511001768.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:GetOverlayCount()>0
end
function c511001768.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511001768.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001768.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511001768.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c511001768.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local og=tc:GetOverlayGroup()
		if og:GetCount()==0 then return end
		Duel.SendtoGrave(og,REASON_EFFECT)
	end
end
