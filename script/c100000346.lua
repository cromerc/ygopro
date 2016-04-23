--森の商人 ポン
function c100000346.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000346,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c100000346.rettg)
	e1:SetOperation(c100000346.retop)
	c:RegisterEffect(e1)
end
function c100000346.filter(c)
	return c:IsType(TYPE_FIELD) and c:IsAbleToDeck()
	 and Duel.IsExistingMatchingCard(c100000346.filter2,tp,LOCATION_DECK,0,1,nil,c:GetCode())
end
function c100000346.filter2(c,code)
	return c:IsType(TYPE_FIELD) and c:GetCode()~=code and c:IsAbleToHand()
end
function c100000346.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000346.filter,tp,LOCATION_HAND,0,1,nil) end
end
function c100000346.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c100000346.filter,tp,LOCATION_HAND,0,1,1,nil)
	local ct=g:GetFirst()
	Duel.SendtoDeck(g,nil,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local dg=Duel.SelectMatchingCard(tp,c100000346.filter2,tp,LOCATION_DECK,0,1,1,nil,ct:GetCode())
	Duel.SendtoDeck(dg:GetFirst(),nil,1,REASON_EFFECT)
end
