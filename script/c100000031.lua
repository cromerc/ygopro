--神事の獣葬
function c100000031.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetTarget(c100000031.target)
	e1:SetOperation(c100000031.activate)
	c:RegisterEffect(e1)
end
function c100000031.cfilter(c,e,tp)
	return c:IsRace(RACE_BEAST) and c:IsFaceup() and c:IsDestructable()
end
function c100000031.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(c100000031.cfilter,tp,LOCATION_MZONE,0,1,nil) and Duel.IsPlayerCanDraw(tp,2) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c100000031.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c100000031.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetCountLimit(1)
		if Duel.GetCurrentPhase()==PHASE_STANDBY then
			e1:SetLabel(Duel.GetTurnCount())
			e1:SetCondition(c100000031.drcon)
			e1:SetReset(RESET_PHASE+PHASE_STANDBY,2)
		else
			e1:SetReset(RESET_PHASE+PHASE_STANDBY)
		end
		e1:SetOperation(c100000031.drop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c100000031.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()~=e:GetLabel()
end
function c100000031.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,100000031)
	Duel.Draw(tp,2,REASON_EFFECT)
end
