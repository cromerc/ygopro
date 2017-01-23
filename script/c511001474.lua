--Card Loan
function c511001474.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001474.cost)
	e1:SetTarget(c511001474.target)
	e1:SetOperation(c511001474.activate)
	c:RegisterEffect(e1)
end
function c511001474.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c511001474.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,1-tp,1000)
end
function c511001474.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local tc=Duel.GetDecktopGroup(p,1):GetFirst()
	if Duel.Draw(p,d,REASON_EFFECT)>0 then
		Duel.BreakEffect()
		Duel.Recover(1-tp,1000,REASON_EFFECT)
		if tc then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCountLimit(1)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetLabelObject(tc)
			e1:SetOperation(c511001474.tdop)
			e1:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e1,tp)
		end
	end
end
function c511001474.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc then
		Duel.Hint(HINT_CARD,0,511001474)
		if tc:IsLocation(LOCATION_DECK) then
			Duel.MoveSequence(tc,1)
		else
			Duel.SendtoDeck(tc,nil,1,REASON_EFFECT)
		end
	end
end
