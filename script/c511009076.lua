--Final Tombstone
function c511009076.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511009076.condition)
	e1:SetTarget(c511009076.target)
	e1:SetOperation(c511009076.activate)
	c:RegisterEffect(e1)
end
function c511009076.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=1000 and Duel.GetLP(1-tp)<=1000
end
function c511009076.filter(c)
	return c:GetControler()~=c:GetOwner()
end
function c511009076.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsDiscardable,tp,LOCATION_HAND,LOCATION_HAND,nil)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,LOCATION_HAND)==g:GetCount() end
	Duel.SetTargetPlayer(PLAYER_ALL)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,PLAYER_ALL,g:GetCount())
end
function c511009076.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_DISCARD+REASON_EFFECT)
	end
end
