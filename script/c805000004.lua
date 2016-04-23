--マジック・リサイクラー
function c805000004.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c805000004.condition)
	e1:SetCost(c805000004.cost)
	e1:SetTarget(c805000004.target)
	e1:SetOperation(c805000004.activate)
	c:RegisterEffect(e1)
end
function c805000004.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c805000004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c805000004.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToDeck()
end
function c805000004.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c805000004.filter(chkc) end
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1)
	 and Duel.IsExistingTarget(c805000004.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c805000004.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c805000004.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 or not sg then return end
	Duel.DiscardDeck(tp,1,REASON_EFFECT)
	Duel.SendtoDeck(sg,nil,1,REASON_EFFECT)
end
