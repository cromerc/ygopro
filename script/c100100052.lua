--Ｓｐ－苦渋の選択
function c100100052.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100100052.cost)
	e1:SetTarget(c100100052.target)
	e1:SetOperation(c100100052.activate)
	c:RegisterEffect(e1)
end
function c100100052.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if chk==0 then return tc and tc:IsCanRemoveCounter(tp,0x91,12,REASON_COST) end	 
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	tc:RemoveCounter(tp,0x91,12,REASON_COST)	
end
function c100100052.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_DECK,0,5,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c100100052.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(100100052,0))
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_DECK,0,5,5,nil)
	if g:GetCount()<5 then return end
	Duel.ConfirmCards(1-tp,g)
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(100100052,1))
	local sg=g:Select(1-tp,1,1,nil)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
	g:Sub(sg)
	Duel.SendtoGrave(g,REASON_EFFECT)
end
