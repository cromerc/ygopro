--Ninjitsu Art of Mosquito Repellent
function c511002892.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetTarget(c511002892.target)
	e1:SetOperation(c511002892.activate)
	c:RegisterEffect(e1)
end
function c511002892.rmfilter(c)
	return (c:IsCode(33695750) or c:IsCode(50074522) or c:IsCode(17285476) or c:IsSetCard(0x21d)) 
		and c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c511002892.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:GetOverlayCount()==0
end
function c511002892.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511002892.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002892.filter,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.IsExistingMatchingCard(c511002892.rmfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511002892.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local rg=Duel.GetMatchingGroup(c511002892.rmfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,rg,rg:GetCount(),0,0)
end
function c511002892.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002892.rmfilter,tp,LOCATION_GRAVE,0,nil)
	local ct=Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) and ct>0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(ct*1000)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc:RegisterFlagEffect(511002892,RESET_EVENT+0x1220000+RESET_PHASE+PHASE_END,0,1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetCategory(CATEGORY_REMOVE+CATEGORY_DAMAGE)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetLabelObject(tc)
		e2:SetCondition(c511002892.rmcon)
		e2:SetTarget(c511002892.rmtg)
		e2:SetOperation(c511002892.rmop)
		e2:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN)
		Duel.RegisterEffect(e2,tp)
	end
end
function c511002892.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511002892.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return tc and tc:GetFlagEffect(511002892)~=0 end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,tc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,tc:GetAttack())
end
function c511002892.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)>0 then
		Duel.Damage(1-tp,tc:GetAttack(),REASON_EFFECT)
	end
end
