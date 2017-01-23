--Compensation Mediation
function c511002404.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002404.condition)
	e1:SetTarget(c511002404.target)
	e1:SetOperation(c511002404.activate)
	c:RegisterEffect(e1)
end
function c511002404.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetLocationCount(tp,LOCATION_MZONE)>2
end
function c511002404.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,0,LOCATION_GRAVE,2,nil) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,2,0,0)
end
function c511002404.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=2 then return end
	local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_GRAVE,nil)
	if g:GetCount()>1 then
		local sg=g:Select(1-tp,2,2,nil)
		sg:AddCard(c)
		local tc=sg:GetFirst()
		while tc do
			Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,POS_FACEDOWN_ATTACK,true)
			tc=sg:GetNext()
		end
		Duel.ShuffleSetCard(sg)
		local rsel=sg:RandomSelect(tp,1)
		Duel.ConfirmCards(tp,rsel)
		Duel.ConfirmCards(1-tp,rsel)
		if rsel:IsContains(c) then
			Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
			sg:RemoveCard(c)
			Duel.SendtoDeck(sg,nil,0,REASON_EFFECT)
			Duel.SendtoGrave(c,REASON_EFFECT)
		else
			Duel.SendtoGrave(sg,REASON_EFFECT)
		end
	end
	
end
