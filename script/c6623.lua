--Scripted by Eerie Code
--Soul of the Supreme Soldier
function c6623.initial_effect(c)
	--Change Name
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6623,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,6623)
	e1:SetCost(c6623.chcost)
	e1:SetOperation(c6623.chop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,6624)
	e2:SetCost(c6623.thcost)
	e2:SetTarget(c6623.thtg)
	e2:SetOperation(c6623.thop)
	c:RegisterEffect(e2)
end

function c6623.cfilter(c)
	return c:IsSetCard(0xd0) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c6623.chcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6623.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c6623.cfilter,1,1,REASON_COST)
end
function c6623.chop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(5405694)
		e1:SetLabel(tp)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END+RESET_OPPO_TURN)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_SET_ATTACK)
		e2:SetValue(3000)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END+RESET_OPPO_TURN)
		c:RegisterEffect(e2)
	end
end

function c6623.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c6623.thfilter(c)
	return (c:IsCode(6621) or c:IsCode(6622)) and c:IsAbleToHand()
end
function c6623.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6623.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c6623.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c6623.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end