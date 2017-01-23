--Ｓｐ－ソーラー·エクスチェンジ
function c100100074.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100100074.con)
	e1:SetCost(c100100074.cost)
	e1:SetTarget(c100100074.target)
	e1:SetOperation(c100100074.activate)
	c:RegisterEffect(e1)
end
function c100100074.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	return tc and tc:GetCounter(0x91)>3
end
function c100100074.costfilter(c)
	return c:IsSetCard(0x38) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c100100074.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100100074.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c100100074.costfilter,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c100100074.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,4) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,2)
end
function c100100074.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	Duel.DiscardDeck(tp,2,REASON_EFFECT)
end
