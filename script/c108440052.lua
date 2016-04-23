--ライトロード・メイデン ミネルバ
function c108440052.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c108440052.target)
	e1:SetOperation(c108440052.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c108440052.tdcon)
	e2:SetTarget(c108440052.tdtg)
	e2:SetOperation(c108440052.tdop)
	c:RegisterEffect(e2)
	--discard deck
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCategory(CATEGORY_DECKDES)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c108440052.discon)
	e4:SetTarget(c108440052.distg)
	e4:SetOperation(c108440052.disop)
	c:RegisterEffect(e4)
end
function c108440052.thfilter(c)
	return c:IsSetCard(0x38) and c:IsType(TYPE_MONSTER)
end
function c108440052.filter(c,lv)
	return c:IsLevelBelow(lv) and c:IsRace(RACE_DRAGON) 
	and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToHand()
end
function c108440052.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local count=Duel.GetMatchingGroup(c108440052.thfilter,tp,LOCATION_GRAVE,0,nil):GetClassCount(Card.GetCode)
		return Duel.IsExistingMatchingCard(c108440052.filter,tp,LOCATION_DECK,0,1,nil,count)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c108440052.operation(e,tp,eg,ep,ev,re,r,rp)
	local count=Duel.GetMatchingGroup(c108440052.thfilter,tp,LOCATION_GRAVE,0,nil):GetClassCount(Card.GetCode)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c108440052.filter,tp,LOCATION_DECK,0,1,1,nil,count)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c108440052.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND) or e:GetHandler():IsPreviousLocation(LOCATION_DECK) 
end
function c108440052.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end
function c108440052.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if  not c:IsRelateToEffect(e) then return end
	Duel.DiscardDeck(tp,1,REASON_EFFECT)
end
function c108440052.discon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c108440052.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,2)
end
function c108440052.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetControler()~=tp or not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	Duel.DiscardDeck(tp,2,REASON_EFFECT)
end