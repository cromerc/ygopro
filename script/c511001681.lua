--Eco Spell - Reduce Waste
function c511001681.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001681.cost)
	e1:SetTarget(c511001681.target)
	e1:SetOperation(c511001681.activate)
	c:RegisterEffect(e1)
end
function c511001681.cfilter(c)
	return c:IsSetCard(0x1043) and c:IsType(TYPE_MONSTER)
end
function c511001681.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local sg=Duel.GetMatchingGroup(c511001681.cfilter,tp,LOCATION_DECK,0,nil)
	local th=sg:Filter(Card.IsAbleToHand,nil)
	local thct=th:GetCount()
	if thct==1 then
		sg:Sub(th)
	end
	if chk==0 then return (sg:GetCount()>=3 or thct==1) and sg:IsExists(Card.IsAbleToRemove,2,nil) 
		and (sg:IsExists(Card.IsAbleToHand,1,nil) or thct==1) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=sg:FilterSelect(tp,Card.IsAbleToRemove,2,2,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511001681.filter(c)
	return c:IsSetCard(0x1043) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c511001681.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001681.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511001681.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511001681.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
