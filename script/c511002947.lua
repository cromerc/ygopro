--ワーム・ホール
function c511002947.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002947.target)
	e1:SetOperation(c511002947.operation)
	c:RegisterEffect(e1)
end
function c511002947.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c511002947.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local seq=tc:GetSequence()
	if tc:IsControler(1-tp) then seq=seq+16 end
	if tc and tc:IsRelateToEffect(e) and Duel.Remove(tc,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_OPPO_TURN)
		e1:SetLabelObject(tc)
		e1:SetCountLimit(1)
		e1:SetCondition(c511002947.rtcon)
		e1:SetOperation(c511002947.retop)
		Duel.RegisterEffect(e1,tp)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_DISABLE_FIELD)
		e2:SetReset(RESET_PHASE+PHASE_DRAW+RESET_OPPO_TURN)
		e2:SetLabel(seq)
		e2:SetLabelObject(tc)
		e2:SetCondition(c511002947.discon)
		e2:SetOperation(c511002947.disop)
		Duel.RegisterEffect(e2,tp)
	end
end
function c511002947.rtcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511002947.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetLabelObject())
end
function c511002947.discon(e,c)
	if e:GetLabelObject():IsLocation(LOCATION_REMOVED) then return true end
	return false
end
function c511002947.disop(e,tp)
	local dis1=bit.lshift(0x1,e:GetLabel())
	return dis1
end
