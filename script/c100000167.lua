--奇跡の穿孔
function c100000167.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000167.target)
	e1:SetOperation(c100000167.activate)
	c:RegisterEffect(e1)
end
function c100000167.tgfilter(c)
	return c:IsRace(RACE_ROCK) and c:IsAbleToGrave()
end
function c100000167.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000167.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c100000167.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100000167.tgfilter,tp,LOCATION_DECK,0,1,1,nil)	
	if g:GetCount()==0 then return end
	Duel.SendtoGrave(g,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.ShuffleDeck(tp)
	if Duel.IsPlayerCanDraw(tp,1) then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
