--Scripted by Eerie Code
--Chaos Field
function c6657.initial_effect(c)
	c:EnableCounterPermit(0x3001)
	c:SetCounterLimit(0x3001,6)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,6657+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c6657.target)
	e1:SetOperation(c6657.activate)
	c:RegisterEffect(e1)
	--Add counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetOperation(c6657.ctop)
	c:RegisterEffect(e2)	
	--to hand
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetCost(c6657.thcost)
	e4:SetTarget(c6657.thtg1)
	e4:SetOperation(c6657.thop1)
	c:RegisterEffect(e4)
end

function c6657.filter(c)
	return c:IsType(TYPE_MONSTER) and ((c:IsSetCard(0xd0) and c:IsType(TYPE_RITUAL)) or c:IsSetCard(0xbd)) and c:IsAbleToHand()
end
function c6657.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6657.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c6657.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c6657.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

function c6657.ctfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsPreviousLocation(LOCATION_ONFIELD+LOCATION_HAND) and not c:IsType(TYPE_TOKEN)
end
function c6657.ctop(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(c6657.ctfilter,nil)
	if ct>0 then
		e:GetHandler():AddCounter(0x3001,ct)
	end
end

function c6657.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x3001,3,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x3001,3,REASON_COST)
end
function c6657.thfilter1(c)
	return bit.band(c:GetType(),0x82)==0x82 and c:IsAbleToHand()
end
function c6657.thtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6657.thfilter1,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c6657.thop1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c6657.thfilter1,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end