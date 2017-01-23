--Scrap-Iron Pitfall
function c511000200.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c511000200.target)
	e1:SetOperation(c511000200.activate)
	c:RegisterEffect(e1)
end
function c511000200.filter(c,tp)
	return c:GetSummonPlayer()~=tp and c:IsAbleToHand()
		and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0,nil)<Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE,nil)
end
function c511000200.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511000200.filter,1,nil,tp) end
	local g=eg:Filter(c511000200.filter,nil,tp)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c511000200.filter2(c,e,tp)
	return c:IsRelateToEffect(e) and c:GetSummonPlayer()~=tp and c:IsAbleToHand()
end
function c511000200.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000200.filter2,nil,e,tp)
	if g then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsCanTurnSet() then
		Duel.BreakEffect()
		c:CancelToGrave()
		Duel.ChangePosition(c,POS_FACEDOWN)
		Duel.RaiseEvent(c,EVENT_SSET,e,REASON_EFFECT,tp,tp,0)
	end
end
