--Star Gatherer
function c511000094.initial_effect(c)
	--Change Level
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000094,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511000094.lvtg)
	e1:SetOperation(c511000094.lvop)
	c:RegisterEffect(e1)
end
function c511000094.lvfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c:GetLevel()>0
end
function c511000094.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511000094.lvfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000094.lvfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511000094.lvfilter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511000094.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc:IsRelateToEffect(e) and c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(tc:GetLevel()-1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
	end
end
