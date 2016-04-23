--魔術師の天秤
function c100000115.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100000115.cost)
	e1:SetTarget(c100000115.target)
	e1:SetOperation(c100000115.activate)
	c:RegisterEffect(e1)
end
function c100000115.filter(c)
	return c:IsSetCard(0x5) and c:IsFaceup()
end
function c100000115.cost(e,tp,eg,ep,ev,re,r,rp,chk)	
	if chk==0 then return Duel.CheckReleaseGroup(tp,c100000115.filter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c100000115.filter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c100000115.afilter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c100000115.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000115.afilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c100000115.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c100000115.afilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
