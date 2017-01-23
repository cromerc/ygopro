--Drawber
function c511000471.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000471.target)
	e1:SetOperation(c511000471.operation)
	c:RegisterEffect(e1)
end
function c511000471.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp,1) end
	Duel.Hint(HINT_SELECTMSG,tp,0)
	local ac=Duel.AnnounceCard(tp)
	e:SetLabel(ac)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
end
function c511000471.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local h=Duel.GetDecktopGroup(1-tp,1)
	local tc=h:GetFirst()
	Duel.Draw(p,d,REASON_EFFECT)
	if tc then
		Duel.ConfirmCards(1-tp,tc)
		if tc:GetCode()==e:GetLabel() then
			Duel.BreakEffect()
			local sg=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD+LOCATION_HAND,nil)
			Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
		end
		Duel.ShuffleHand(1-tp)
	end
end
