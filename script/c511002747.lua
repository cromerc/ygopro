--Overlay Flash
function c511002747.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002747.target)
	e1:SetOperation(c511002747.operation)
	c:RegisterEffect(e1)
end
function c511002747.filter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:CheckRemoveOverlayCard(tp,1,REASON_COST)
end
function c511002747.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511002747.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511002747.filter,tp,LOCATION_MZONE,0,1,nil,tp) 
		and Duel.IsExistingMatchingCard(aux.disfilter1,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511002747.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	g:GetFirst():RemoveOverlayCard(tp,1,1,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,nil,1,0,0)
end
function c511002747.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetFirstTarget()
	if tg and tg:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local g=Duel.SelectMatchingCard(tp,aux.disfilter1,tp,0,LOCATION_MZONE,1,1,nil)
		local tc=g:GetFirst()
		if tc then
			tg:SetCardTarget(tc)
			Duel.HintSelection(g)
			Duel.NegateRelatedChain(tc,RESET_TURN_SET)
			local e1=Effect.CreateEffect(tg)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetCondition(c511002747.rcon)
			tc:RegisterEffect(e1,true)
		end
	end
end
function c511002747.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
