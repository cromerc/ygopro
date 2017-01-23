--Morphtronic Impact Return
function c511000933.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000933.target)
	e1:SetOperation(c511000933.activate)
	c:RegisterEffect(e1)
end
function c511000933.retfilter(c)
	return c:IsSetCard(0x26) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c511000933.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c511000933.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c511000933.filter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c511000933.retfilter,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsExistingTarget(c511000933.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c511000933.filter,tp,0,LOCATION_ONFIELD,1,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c511000933.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=tg:Filter(Card.IsRelateToEffect,nil,e)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c511000933.retfilter,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.ConfirmCards(1-tp,g)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
end
