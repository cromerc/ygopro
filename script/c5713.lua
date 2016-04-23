--死なばもろとも
function c5713.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,5713+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c5713.condition)
	e1:SetTarget(c5713.target)
	e1:SetOperation(c5713.activate)
	c:RegisterEffect(e1)
end
function c5713.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>=3 and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>=3
end
function c5713.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,5) and Duel.IsPlayerCanDraw(1-tp,5) end
	local g1=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g1,g1:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,5)
end
function c5713.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	local ct2=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g1=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,ct1,ct1,nil)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TODECK)
	local g2=Duel.SelectMatchingCard(1-tp,aux.TRUE,tp,0,LOCATION_HAND,ct2,ct2,nil)
	g1:Merge(g2)
	local count=Duel.SendtoDeck(g1,nil,1,REASON_EFFECT)
	if count>1 then
		Duel.BreakEffect()
		local lp=Duel.GetLP(tp)
		if lp<=count*300 then
			Duel.SetLP(tp,0)
		else
			Duel.SetLP(tp,lp-count*300)
		end
		Duel.Draw(tp,5,REASON_EFFECT)
		Duel.Draw(1-tp,5,REASON_EFFECT)
	end
end
