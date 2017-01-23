--Dragged Down into the Grave (anime)
function c511000218.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000218.condition)
	e1:SetTarget(c511000218.target)
	e1:SetOperation(c511000218.activate)
	c:RegisterEffect(e1)
end
function c511000218.condition(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsLocation(LOCATION_HAND) then
		return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>1 and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>2
	else
		return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>1 and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>1
	end
end
function c511000218.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,PLAYER_ALL,2)
end
function c511000218.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)<=1 or Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)<=1 then return end
	local g1=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	local g2=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	local gc1=g1:GetCount()
	local gc2=g2:GetCount()
	Duel.ConfirmCards(tp,g1)
	Duel.ConfirmCards(1-tp,g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg1=g1:Select(tp,2,2,nil)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DISCARD)
	local sg2=g2:Select(1-tp,2,2,nil)
	sg1:Merge(sg2)
	Duel.SendtoGrave(sg1,REASON_EFFECT+REASON_DISCARD)
	Duel.BreakEffect()
	g1=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	g2=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoDeck(g1,nil,2,REASON_EFFECT)
	Duel.SendtoDeck(g2,nil,2,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.ShuffleDeck(1-tp)
	Duel.BreakEffect()
	Duel.Draw(tp,gc2,REASON_EFFECT)
	Duel.Draw(1-tp,gc1,REASON_EFFECT)
end
