--Hopeful Future
function c511000344.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000344.condition)
	e1:SetTarget(c511000344.target)
	e1:SetOperation(c511000344.activate)
	c:RegisterEffect(e1)
end
function c511000344.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
end
function c511000344.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)>0 and Duel.IsPlayerCanDraw(tp,2) end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND+LOCATION_GRAVE,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c511000344.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_GRAVE,0)
	if Duel.SendtoDeck(g,nil,2,REASON_EFFECT) then
		Duel.ShuffleDeck(tp)
		Duel.BreakEffect()
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
