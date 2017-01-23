--アフター・グロー 
function c100000020.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)	
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c100000020.activate)
	c:RegisterEffect(e1)
end
function c100000020.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		c:CancelToGrave()
		Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_DELAY)
		e1:SetCode(EVENT_DRAW)
		e1:SetCountLimit(1)
		e1:SetCondition(c100000020.con)
		e1:SetOperation(c100000020.op)
		if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_DRAW then
			e1:SetLabel(Duel.GetTurnCount())
			e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN,2)
		else
			e1:SetLabel(0)
			e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN)
		end
		Duel.RegisterEffect(e1,tp)
	end
end
function c100000020.con(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and bit.band(r,REASON_RULE)~=0 and Duel.GetTurnPlayer()==tp and Duel.GetTurnCount()~=e:GetLabel() 
		and Duel.GetCurrentPhase()==PHASE_DRAW
end
function c100000020.op(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(Card.IsControler,nil,tp)
	if g:GetCount()<=0 then return end
	Duel.Hint(HINT_CARD,0,100000020)
	Duel.ConfirmCards(1-tp,g)
	if eg:IsExists(Card.IsCode,1,nil,100000020) then
		Duel.Damage(1-tp,8000,REASON_EFFECT)
	end
	Duel.ShuffleHand(tp)
end
