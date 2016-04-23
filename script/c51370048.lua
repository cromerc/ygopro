--Coinorma the Sibyl
function c51370048.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetTarget(c51370048.target)
	e1:SetOperation(c51370048.operation)
	c:RegisterEffect(e1)
end
function c51370048.filter(c)
	return c:IsType(TYPE_FLIP) and c:IsLevelBelow(4)
end
function c51370048.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE+LOCATION_DECK) and c51370048.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c51370048.filter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c51370048.filter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c51370048.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetFirstTarget()
	Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEDOWN_DEFENCE)
		Duel.ConfirmCards(1-tp,sg)
end
