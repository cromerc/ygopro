--Ｓｐ－強欲なウツボ
function c100100047.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100100047.cost)
	e1:SetTarget(c100100047.target)
	e1:SetOperation(c100100047.activate)
	c:RegisterEffect(e1)
end
function c100100047.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if chk==0 then return tc and tc:IsCanRemoveCounter(tp,0x91,2,REASON_COST) end	 
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	tc:RemoveCounter(tp,0x91,2,REASON_COST)	
end
function c100100047.filter(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsAbleToDeck()
end
function c100100047.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3)
		and Duel.IsExistingMatchingCard(c100100047.filter,tp,LOCATION_HAND,0,2,e:GetHandler()) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,2,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,3)
end
function c100100047.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetMatchingGroup(c100100047.filter,p,LOCATION_HAND,0,nil)
	if g:GetCount()<2 then
		local hg=Duel.GetFieldGroup(p,LOCATION_HAND,0)
		Duel.ConfirmCards(1-p,hg)
		Duel.ShuffleHand(p)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local sg=g:Select(p,2,2,nil)
		Duel.ConfirmCards(1-p,sg)
		Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
		Duel.ShuffleDeck(p)
		Duel.BreakEffect()
		Duel.Draw(p,3,REASON_EFFECT)
	end
end
