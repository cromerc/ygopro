--アフター・グロー 
function c100000020.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)	
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000020.tdtg)
	e1:SetOperation(c100000020.activate)
	c:RegisterEffect(e1)
end
function c100000020.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c100000020.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsCanTurnSet() and Duel.GetFlagEffect(tp,100000020)==0 then
		Duel.RegisterFlagEffect(tp,100000020,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCategory(CATEGORY_DAMAGE)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_DELAY)
		e1:SetCode(EVENT_DRAW)	
		e1:SetCountLimit(1)
		e1:SetCondition(c100000020.spcon)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
		e1:SetOperation(c100000020.spop1)
		Duel.RegisterEffect(e1,tp)
	end
	Duel.BreakEffect()
	c:CancelToGrave()
	Duel.SendtoDeck(c,nil,1,REASON_EFFECT)
	Duel.ShuffleDeck(c:GetControler())
end
function c100000020.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.GetCurrentPhase()==PHASE_DRAW
end
function c100000020.spop1(e,tp,eg,ep,ev,re,r,rp)
	if ep~=e:GetOwnerPlayer() then return end
	local tc=eg:GetFirst()
	Duel.ConfirmCards(tp,tc)
		if tc:GetCode()==100000020 then
			local p=e:GetHandler():GetControler()
			Duel.Damage(1-tp,8000,REASON_EFFECT)
		end
	Duel.ShuffleHand(tp)
end