--Blizzard Jet
function c511000577.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000577.target)
	e1:SetOperation(c511000577.activate)
	c:RegisterEffect(e1)
end
function c511000577.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_WINDBEAST) and c:IsAttribute(ATTRIBUTE_WATER)
end
function c511000577.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000577.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000577.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511000577.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c511000577.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(1500)
		tc:RegisterEffect(e1)
	end
end
