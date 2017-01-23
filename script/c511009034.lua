--Scale Up
function c511009034.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511009034.target)
	e1:SetOperation(c511009034.activate)
	c:RegisterEffect(e1)
end
function c511009034.filter(c)
	return c:IsFaceup() and (c:GetSequence()==6 or c:GetSequence()==7)
end
function c511009034.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c511009034.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009034.filter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511009034.filter,tp,LOCATION_SZONE,0,1,1,nil)
end
function c511009034.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LSCALE)
		e1:SetValue(2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_RSCALE)
		tc:RegisterEffect(e2)
	end
end
