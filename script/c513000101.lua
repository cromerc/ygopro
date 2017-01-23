--Scrap-Iron Pitfall
function c513000101.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c513000101.target)
	e1:SetOperation(c513000101.activate)
	c:RegisterEffect(e1)
end
function c513000101.filter(c,e,tp)
	return c:GetSummonPlayer()~=tp and c:IsAbleToHand() and (not e or c:IsRelateToEffect(e))
end
function c513000101.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c513000101.filter,nil,nil,tp)
	if chk==0 then return g:GetCount()==1 end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c513000101.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c513000101.filter,nil,e,tp)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsCanTurnSet() then
		Duel.BreakEffect()
		c:CancelToGrave()
		Duel.ChangePosition(c,POS_FACEDOWN)
		Duel.RaiseEvent(c,EVENT_SSET,e,REASON_EFFECT,tp,tp,0)
	end
end
