--Insect Costume
function c511000960.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)	
	e1:SetCost(c511000960.cost)	
	e1:SetTarget(c511000960.target)
	e1:SetOperation(c511000960.activate)
	c:RegisterEffect(e1)
end
function c511000960.cfilter(c)
	return c:IsRace(RACE_INSECT) and c:IsAbleToGrave()
end
function c511000960.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000960.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511000960.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511000960.filter(c)
	return c:IsRace(RACE_INSECT) and c:IsAbleToHand()
end
function c511000960.desfilter(c)
	return c:IsFaceup() and c:IsDestructable() and c:IsRace(RACE_INSECT)
end
function c511000960.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000960.filter,tp,LOCATION_DECK,0,1,nil) 
		and Duel.IsExistingMatchingCard(c511000960.desfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
end
function c511000960.activate(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511000960.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local d=Duel.SelectMatchingCard(tp,c511000960.desfilter,tp,LOCATION_MZONE,0,1,1,nil)
		if d:GetCount()>0 then
			Duel.HintSelection(d)
			Duel.Destroy(d,REASON_EFFECT)
		end
	end
end
