--Ｓｉｎ Ｓｅｌｅｃｔｏｒ
function c100000091.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100000091.cost)
	e1:SetTarget(c100000091.target)
	e1:SetOperation(c100000091.activate)
	c:RegisterEffect(e1)
end
function c100000091.cfilter(c)
	return c:IsSetCard(0x23) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c100000091.filter(c)
	return c:IsSetCard(0x23) and c:IsAbleToHand()
end
function c100000091.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000091.cfilter,tp,LOCATION_GRAVE,0,2,nil) end
	local g=Duel.SelectMatchingCard(tp,c100000091.cfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c100000091.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000091.filter,tp,LOCATION_DECK,0,2,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c100000091.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c100000091.filter,tp,LOCATION_DECK,0,2,2,nil)
	if g:GetCount()>1 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
