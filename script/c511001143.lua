--Power Balance
function c511001143.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COIN+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001143.condition)
	e1:SetTarget(c511001143.target)
	e1:SetOperation(c511001143.activate)
	c:RegisterEffect(e1)
end
function c511001143.condition(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)% 2 == 0) and tp~=Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
end
function c511001143.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,tp,0,1)
end
function c511001143.activate(e,tp,eg,ep,ev,re,r,rp)
	local h1=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	local g=Duel.GetFieldGroup(ep,LOCATION_HAND,0,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DISCARD)
	local sg=g:Select(1-tp,h1/2,h1/2,nil)
	Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Draw(tp,h1/2,REASON_EFFECT)
end
