--Ｓｉｎ Ｓｅｌｅｃｔｏｒ
function c513000071.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c513000071.cost)
	e1:SetTarget(c513000071.target)
	e1:SetOperation(c513000071.activate)
	c:RegisterEffect(e1)
end
function c513000071.cfilter(c)
	return c:IsSetCard(0x23) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c513000071.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c513000071.cfilter,tp,LOCATION_GRAVE,0,2,nil) end
	local g=Duel.SelectMatchingCard(tp,c513000071.cfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c513000071.filter(c)
	return c:IsSetCard(0x23) and c:IsAbleToHand()
end
function c513000071.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c513000071.filter,tp,LOCATION_DECK,0,2,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_DECK)
end
function c513000071.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c513000071.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local tg=g:Select(tp,2,2,nil)
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end
