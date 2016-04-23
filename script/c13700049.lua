--Jinzo - Jacker
function c13700049.initial_effect(c)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CHANGE_CODE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e3:SetValue(77585513)
	c:RegisterEffect(e3)
	--seaRevealedCardsh
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,13700049)
	e1:SetCost(c13700049.cost)
	e1:SetTarget(c13700049.target)
	e1:SetOperation(c13700049.operation)
	c:RegisterEffect(e1)
end
function c13700049.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c13700049.filter(c)
	return (c:IsCode(9418534) or  c:IsCode(32809211) or  c:IsCode(35803249) or c:IsCode(77585513)) and c:IsAbleToHand()
end
function c13700049.filter2(c,e,tp)
	return (c:IsCode(9418534) or  c:IsCode(32809211) or  c:IsCode(35803249) or c:IsCode(77585513) or c:IsCode(13700049)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c13700049.setfilter(c)
	return c:IsType(TYPE_TRAP) and c:IsFacedown()
end
function c13700049.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13700049.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13700049.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c13700049.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end	
	local SetCards=Duel.GetMatchingGroupCount(c13700049.setfilter,tp,0,LOCATION_SZONE,nil)*1	
	local RevealedCards=Duel.GetFieldGroup(tp,0,LOCATION_SZONE)
	Duel.ConfirmCards(tp,RevealedCards)
	local Jinzo=Duel.SelectMatchingCard(tp,c13700049.filter2,tp,LOCATION_HAND,0,1,SetCards,nil,e,tp)
	Duel.SpecialSummon(Jinzo,0,tp,tp,false,false,POS_FACEUP)
end
