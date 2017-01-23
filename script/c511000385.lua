--Beast-Concealed Mantra
function c511000385.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c511000385.condition)
	e1:SetTarget(c511000385.target)
	e1:SetOperation(c511000385.activate)
	c:RegisterEffect(e1)
end
function c511000385.cfilter(c,tp)
	return c:IsSetCard(0x201)
end
function c511000385.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000385.cfilter,1,nil,tp)
end
function c511000385.filter(c)
	return c:IsCode(511000380) and c:IsAbleToHand()
end
function c511000385.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000385.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511000385.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511000385.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
