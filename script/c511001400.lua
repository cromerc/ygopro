--Animal Trail
function c511001400.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c511001400.condition)
	e1:SetTarget(c511001400.target)
	e1:SetOperation(c511001400.activate)
	c:RegisterEffect(e1)
end
function c511001400.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE) and c:GetPreviousControler()==tp
end
function c511001400.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001400.cfilter,1,nil,tp)
end
function c511001400.afilter(c)
	return c:IsRace(RACE_BEAST) and c:IsAbleToHand()
end
function c511001400.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001400.afilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511001400.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511001400.afilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
