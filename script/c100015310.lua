--100015310
function c100015310.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c100015310.target)
	e2:SetOperation(c100015310.operation)
	c:RegisterEffect(e2)
end
function c100015310.filter(c)
	return c:IsSetCard(0x400) and c:IsSetCard(0x45) 
end
function c100015310.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and chkc:IsAbleToDeck() end
	if chk==0 then return e:GetHandler():IsLocation(LOCATION_SZONE) and not e:GetHandler():IsStatus(STATUS_CHAINING) end
	if eg:IsExists(c100015310.filter,1,nil,tp) then
	e:GetHandler():RegisterFlagEffect(100015310,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_GRAVE+LOCATION_REMOVED,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c100015310.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.BreakEffect()
	Duel.SendtoDeck(sg,nil,1,REASON_EFFECT)		
	if e:GetHandler():GetFlagEffect(100015310)~=0 then
		local dg=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
		if dg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(100015310,0)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local des=dg:Select(tp,1,1,nil)
			Duel.BreakEffect()
			Duel.SendtoHand(des,tp,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,des)
		end
	end
end