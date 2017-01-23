--エクスチェンジ
function c95200006.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95200006.target)
	e1:SetOperation(c95200006.activate)
	c:RegisterEffect(e1)
end
function c95200006.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,PLAYER_ALL,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,2)
end
function c95200006.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g1:GetCount()==0 or g2:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg1=g1:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TODECK)
	local sg2=g2:Select(1-tp,1,1,nil)
	sg1:Merge(sg2)
	Duel.SendtoDeck(sg1,nil,1,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Draw(tp,2,REASON_EFFECT)
	Duel.Draw(1-tp,2,REASON_EFFECT)
end
