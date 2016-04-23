--Dogking
function c13700027.initial_effect(c)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(13700027,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_RELEASE)
	e2:SetCondition(c13700027.retcon)
	e2:SetTarget(c13700027.target)
	e2:SetOperation(c13700027.operation)
	c:RegisterEffect(e2)
	--ritual level
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_RITUAL_LEVEL)
	e2:SetValue(c13700027.rlevel)
	c:RegisterEffect(e2)
end
function c13700027.retcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and 
	e:GetHandler():IsReason(REASON_EFFECT)
end
function c13700027.filter(c)
	return c:IsSetCard(0x1373) and c:IsType(TYPE_RITUAL) and 
	c:IsRace(RACE_WARRIOR) and c:IsAbleToHand()
end
function c13700027.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c13700027.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13700027.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.SelectMatchingCard(tp,c13700027.filter,tp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
end

function c13700027.rlevel(e,c)
	local lv=e:GetHandler():GetLevel()
	if c:IsSetCard(0x1373) then
		local clv=c:GetLevel()
		return lv*65536+clv
	else return lv end
end
