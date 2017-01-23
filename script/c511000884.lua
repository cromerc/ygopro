--Down Burst
function c511000884.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000884.target)
	e1:SetOperation(c511000884.activate)
	c:RegisterEffect(e1)
end
function c511000884.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsCanTurnSet()
end
function c511000884.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000884.filter,tp,0,LOCATION_ONFIELD,1,nil) end
end
function c511000884.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511000884.filter,tp,0,LOCATION_ONFIELD,nil)
	local tc=sg:GetFirst()
	while tc do
		tc:CancelToGrave()
		Duel.ChangePosition(tc,POS_FACEDOWN)
		tc=sg:GetNext()
	end
	Duel.RaiseEvent(sg,EVENT_SSET,e,REASON_EFFECT,1-tp,tp,0)
end
