--Rank-Up Rising
function c511001178.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c511001178.condition)
	e1:SetTarget(c511001178.target)
	e1:SetOperation(c511001178.activate)
	c:RegisterEffect(e1)
end
function c511001178.cfilter(c,tp)
	return c:IsReason(REASON_DESTROY) and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp and c:IsPreviousPosition(POS_FACEUP)
		and c:IsAttribute(ATTRIBUTE_WATER)
end
function c511001178.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001178.cfilter,1,nil,tp)
end
function c511001178.filter(c)
	return c:IsSetCard(0x95) and c:IsAbleToHand()
end
function c511001178.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001178.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511001178.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511001178.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
