--Piri Reis Map
function c511001757.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001757.target)
	e1:SetOperation(c511001757.activate)
	c:RegisterEffect(e1)
end
function c511001757.afilter(c)
	return c:GetAttack()==0 and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c511001757.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001757.afilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511001757.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tc=Duel.SelectMatchingCard(tp,c511001757.afilter,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
	if tc and Duel.SendtoHand(tc,nil,REASON_EFFECT) then
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SUMMON_COST)
		e1:SetOperation(c511001757.sumcost)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SPSUMMON_COST)
		tc:RegisterEffect(e2)
	end
end
function c511001757.sumcost(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(tp,Duel.GetLP(tp)/2)
end
