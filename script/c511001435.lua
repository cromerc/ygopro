--スター・ブライト・ドラゴン
function c511001435.initial_effect(c)
	--lv up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16719802,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c511001435.tg)
	e1:SetOperation(c511001435.op)
	c:RegisterEffect(e1)
end
function c511001435.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c511001435.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511001435.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c511001435.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511001435.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler())
end
function c511001435.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(14812659,0))
		local ac=Duel.AnnounceNumber(tp,1,2)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(ac)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
