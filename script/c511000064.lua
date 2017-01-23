--Slash Draw
function c511000064.initial_effect(c)
	--discard deck
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DECKDES+CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000064.cost)
	e1:SetTarget(c511000064.target)
	e1:SetOperation(c511000064.operation)
	c:RegisterEffect(e1)
end
function c511000064.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c511000064.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511000064.tfilter(c)
	return c:IsDestructable()
end
function c511000064.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetFieldGroupCount(c:GetControler(),LOCATION_ONFIELD,LOCATION_ONFIELD)
	if Duel.DiscardDeck(tp,g,REASON_EFFECT)>0 then
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		local h=Duel.GetDecktopGroup(tp,1)
		local tc=h:GetFirst()
		Duel.Draw(p,d,REASON_EFFECT)
		if tc then
			Duel.ConfirmCards(1-tp,tc)
			if tc:GetCode()==511000064 then
				Duel.BreakEffect()
				if Duel.SendtoGrave(tc,REASON_COST)>0 then
					local i=Duel.GetMatchingGroup(c511000064.tfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
					local ct=Duel.Destroy(i,REASON_EFFECT)
					Duel.Damage(1-tp,ct*1000,REASON_EFFECT)
				end
			end
			Duel.ShuffleHand(tp)
		end		
	end
end
