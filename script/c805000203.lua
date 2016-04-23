--竜の霊廟
function c805000203.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetLabel(0)
	e1:SetCost(c805000203.cost)
	e1:SetTarget(c805000203.target)
	e1:SetOperation(c805000203.activate)
	c:RegisterEffect(e1)
end
function c805000203.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	if chk==0 then return Duel.GetFlagEffect(tp,805000203)==0 end
	Duel.RegisterFlagEffect(tp,805000203,RESET_PHASE+PHASE_END,0,1)
end
function c805000203.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave() and c:IsRace(RACE_DRAGON)
end
function c805000203.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c805000203.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c805000203.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c805000203.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if Duel.SendtoGrave(g,REASON_EFFECT)>0 then
		local dc=Duel.GetOperatedGroup():FilterCount(Card.IsType,nil,TYPE_NORMAL)	
		if dc>0 and Duel.IsExistingMatchingCard(c805000203.tgfilter,tp,LOCATION_DECK,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(110000000,7))	then
			g=Duel.SelectMatchingCard(tp,c805000203.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
			Duel.BreakEffect()		
			Duel.SendtoGrave(g,REASON_EFFECT)
		end
	end
end
