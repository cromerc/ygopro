--聖光の宣告者
function c805000058.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.XyzFilterFunction(c,2),2)
	c:EnableReviveLimit()
	--ret
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(805000058,0))
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c805000058.cost)
	e1:SetTarget(c805000058.target)
	e1:SetOperation(c805000058.operation)
	c:RegisterEffect(e1)
end
function c805000058.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,805000058)==0
		and e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	Duel.RegisterFlagEffect(tp,805000058,RESET_PHASE+PHASE_END,0,1)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c805000058.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c805000058.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c805000058.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c805000058.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOHAND)
	local g=Duel.SelectTarget(tp,c805000058.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c805000058.tgfilter(c,e)
	return not c:IsRelateToEffect(e)
end
function c805000058.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if tg:IsExists(c805000058.tgfilter,1,nil,e) then return end
	local ct=Duel.SendtoHand(tg,nil,0,REASON_EFFECT)
	Duel.ShuffleHand(tp)
	if ct~=0 then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,1,1,nil)
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end
