--ザ・マテリアル・ロード
function c100000107.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCondition(c100000107.condition)
	e1:SetTarget(c100000107.target)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000107,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCost(c100000107.thcost)
	e2:SetTarget(c100000107.thtg)
	e2:SetOperation(c100000107.thop)
	c:RegisterEffect(e2)
end
function c100000107.cfilter(c)
	return c:IsLevelBelow(4) and c:IsSetCard(0x5)
end
function c100000107.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000107.cfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c100000107.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if c100000107.thcost(e,tp,eg,ep,ev,re,r,rp,0) and c100000107.thtg(e,tp,eg,ep,ev,re,r,rp,0) 
		and Duel.SelectYesNo(tp,aux.Stringid(65872270,0)) then
		e:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
		e:SetOperation(c100000107.thop)
		c100000107.thcost(e,tp,eg,ep,ev,re,r,rp,1)
		c100000107.thtg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetCategory(0)
		e:SetOperation(nil)
	end
end
function c100000107.costfilter(c)
	return c:IsSetCard(0x5) and (c:GetLevel()==5 or c:GetLevel()==6) and c:IsAbleToGraveAsCost()
end
function c100000107.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000107.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100000107.costfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c100000107.filter(c)
	return c:IsCode(100000108) and c:IsAbleToHand()
end
function c100000107.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000107.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c100000107.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local dg=Duel.SelectMatchingCard(tp,c100000107.filter,tp,LOCATION_DECK,0,1,1,nil)
	if dg:GetCount()>0 then	
		Duel.SendtoHand(dg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,dg)
	end
end
