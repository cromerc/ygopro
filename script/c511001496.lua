--Break the Seal
function c511001496.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001496.target)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCost(c511001496.cost)
	e2:SetTarget(c511001496.tg)
	e2:SetOperation(c511001496.op)
	c:RegisterEffect(e2)
end
function c511001496.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if c511001496.cost(e,tp,eg,ep,ev,re,r,rp,0) and c511001496.tg(e,tp,eg,ep,ev,re,r,rp,0) and Duel.SelectYesNo(tp,aux.Stringid(65872270,0)) then
		e:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
		e:SetOperation(c511001496.op)
		c511001496.cost(e,tp,eg,ep,ev,re,r,rp,1)
		c511001496.tg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetCategory(0)
		e:SetOperation(nil)
	end
end
function c511001496.cfilter(c)
	return c:IsFaceup() and c:IsCode(511001496) and c:IsAbleToGraveAsCost()
end
function c511001496.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() 
		and Duel.IsExistingMatchingCard(c511001496.cfilter,tp,LOCATION_SZONE,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511001496.cfilter,tp,LOCATION_SZONE,0,1,1,c)
	g:AddCard(c)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511001496.afilter(c)
	return c:IsSetCard(0x40) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c511001496.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001496.afilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511001496.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511001496.afilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
