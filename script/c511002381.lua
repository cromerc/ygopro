--Performapal Corn
function c511002381.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511002381.thcost)
	e1:SetTarget(c511002381.thtg)
	e1:SetOperation(c511002381.thop)
	c:RegisterEffect(e1)
end
function c511002381.cfilter(c)
	return c:IsCode(511002380) and c:IsPosition(POS_FACEUP_ATTACK)
end
function c511002381.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAttackPos() and Duel.IsExistingMatchingCard(c511002381.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACK)
	local g=Duel.SelectMatchingCard(tp,c511002381.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	g:AddCard(c)
	Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
end
function c511002381.filter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c511002381.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002381.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511002381.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511002381.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
