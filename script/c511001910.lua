--デステニー・デストロイ
function c511001910.initial_effect(c)
	--discard deck
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DECKDES+CATEGORY_DAMAGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTarget(c511001910.target)
	e1:SetOperation(c511001910.activate)
	c:RegisterEffect(e1)
end
function c511001910.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,5) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(5)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,5)
end
function c511001910.filter(c)
	return c:IsLocation(LOCATION_GRAVE) and c:IsType(TYPE_SPELL)
end
function c511001910.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,val=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.DiscardDeck(p,val,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	local ct=g:FilterCount(c511001910.filter,nil)
	if ct>0 then
		Duel.Damage(tp,ct*100,REASON_EFFECT)
	end
end
