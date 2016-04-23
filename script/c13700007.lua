--Netcloth Sorcerer
function c13700007.initial_effect(c)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(13700007,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_RELEASE)
	e2:SetCountLimit(1,13700007)
	e2:SetCondition(c13700007.retcon)
	e2:SetTarget(c13700007.target)
	e2:SetOperation(c13700007.operation)
	c:RegisterEffect(e2)
	--tograve
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(13700007,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,13700007)
	e2:SetCode(EVENT_REMOVE)
	e2:SetTarget(c13700007.tgtg)
	e2:SetOperation(c13700007.tgop)
	c:RegisterEffect(e2)
end
function c13700007.retcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and 
	e:GetHandler():IsReason(REASON_EFFECT)
end
function c13700007.filter(c)
	return c:IsSetCard(0x1373) and c:IsType(TYPE_RITUAL) and 
	c:IsRace(RACE_SPELLCASTER) and c:IsAbleToHand()
end
function c13700007.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c13700007.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13700007.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.SelectMatchingCard(tp,c13700007.filter,tp,LOCATION_DECK,0,1,1,nil)
	if tg then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end

function c13700007.tgfilter(c)
	return c:IsSetCard(0x1373) and c:IsType(TYPE_MONSTER) and c:GetCode()~=13700007
	and c:IsAbleToGrave()
end
function c13700007.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13700007.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c13700007.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c13700007.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
