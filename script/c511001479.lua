--Overtraining
function c511001479.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511001479.target)
	e1:SetOperation(c511001479.activate)
	c:RegisterEffect(e1)
end
function c511001479.filter(c)
	return c:IsFaceup() and c:GetFlagEffect(511001479)==0
end
function c511001479.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001479.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001479.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511001479.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001479.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsType(TYPE_MONSTER) and tc:GetFlagEffect(511001479)==0 then
		tc:RegisterFlagEffect(511001479,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		tc:RegisterEffect(e2)
		tc:RegisterFlagEffect(511001480,RESET_EVENT+0x1fe0000,0,1)
		local de=Effect.CreateEffect(e:GetHandler())
		de:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		de:SetCode(EVENT_PHASE+PHASE_END)
		de:SetCountLimit(1)
		de:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		de:SetLabelObject(tc)
		de:SetCondition(c511001479.descon)
		de:SetOperation(c511001479.desop)
		if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_END then
			de:SetLabel(Duel.GetTurnCount())
			de:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
		else
			de:SetLabel(0)
			de:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN)
		end
		Duel.RegisterEffect(de,tp)
	end
end
function c511001479.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return Duel.GetTurnPlayer()==tp and Duel.GetTurnCount()~=e:GetLabel() and tc:GetFlagEffect(511001480)~=0
end
function c511001479.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Destroy(tc,REASON_EFFECT)
	Duel.SendtoGrave(tc,REASON_EFFECT)
end
