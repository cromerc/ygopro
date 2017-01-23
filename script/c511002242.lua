--EinRoid
function c511002242.initial_effect(c)
	--send to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000506,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetTarget(c511002242.target)
	e1:SetOperation(c511002242.operation)
	c:RegisterEffect(e1)
end
function c511002242.tgfilter(c)
	return c:IsSetCard(0x16) and c:IsAbleToGrave()
end
function c511002242.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,2,tp,LOCATION_DECK)
end
function c511002242.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002242.tgfilter,tp,LOCATION_DECK,0,nil)
	local ct=Duel.GetMatchingGroupCount(Card.IsAbleToGrave,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g:Select(tp,2,2,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT)
	elseif g:GetCount()==1 then
		Duel.ConfirmCards(1-tp,g)
		Duel.ConfirmCards(tp,g)
		local cg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
		Duel.ConfirmCards(1-tp,cg)
		Duel.ConfirmCards(tp,cg)
		Duel.ShuffleDeck(tp)
	elseif ct>0 then
		local cg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
		Duel.ConfirmCards(1-tp,cg)
		Duel.ConfirmCards(tp,cg)
		Duel.ShuffleDeck(tp)
	end
end
