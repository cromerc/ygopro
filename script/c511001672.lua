--Overlay Break
function c511001672.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001672.cost)
	e1:SetTarget(c511001672.target)
	e1:SetOperation(c511001672.operation)
	c:RegisterEffect(e1)
end
function c511001672.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c511001672.filter(c,cst)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and (not cst or c:GetOverlayCount()~=0)
end
function c511001672.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local chkcost=e:GetLabel()==1 and true or false
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511001672.filter(chkc,chkcost) end
	if chk==0 then
		e:SetLabel(0)
		return Duel.IsExistingTarget(c511001672.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,chkcost)
	end
	e:SetLabel(0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511001672.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,chkcost)
end
function c511001672.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local og=tc:GetOverlayGroup()
		if Duel.SendtoGrave(og,REASON_EFFECT)~=0 and tc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
			Duel.NegateRelatedChain(tc,RESET_TURN_SET)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetValue(RESET_TURN_SET)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2)
		end
	end
end
