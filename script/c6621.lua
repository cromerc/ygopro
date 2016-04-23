--Scripted by Eerie Code
--Knight of the Evening Twilight
function c6621.initial_effect(c)
	--Search Monster
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6621,2))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_REMOVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,6621)
	e1:SetCondition(c6621.thcon)
	e1:SetTarget(c6621.thtg)
	e1:SetOperation(c6621.thop)
	c:RegisterEffect(e1)
	--Become material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCountLimit(1,6622)
	e2:SetCondition(c6621.condition)
	e2:SetOperation(c6621.operation)
	c:RegisterEffect(e2)
end

function c6621.cfilter(c,e,tp)
	return c==e:GetHandler() and c:IsPreviousLocation(LOCATION_GRAVE) and c:GetPreviousControler()==tp
end
function c6621.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_GRAVE)
	--return eg:IsExists(c6621.cfilter,1,nil,e,tp)
	return c:IsPreviousLocation(LOCATION_GRAVE) and c:GetPreviousControler()==tp
end
function c6621.thfilter(c)
	return bit.band(c:GetType(),0x81)==0x81 and c:IsAbleToHand()
end
function c6621.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6621.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c6621.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c6621.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

function c6621.condition(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_RITUAL
end
function c6621.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=eg:GetFirst()
	while rc do
		if rc:GetFlagEffect(6621)==0 then
			--Banish monster
			local e1=Effect.CreateEffect(c)
			e1:SetDescription(aux.Stringid(6621,0))
			e1:SetCategory(CATEGORY_REMOVE)
			e1:SetType(EFFECT_TYPE_IGNITION)
			e1:SetRange(LOCATION_MZONE)
			e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
			e1:SetCountLimit(1)
			e1:SetTarget(c6621.rmtg1)
			e1:SetOperation(c6621.rmop1)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			rc:RegisterEffect(e1)
			--Banish from hand
			local e2=Effect.CreateEffect(c)
			e2:SetDescription(aux.Stringid(6621,1))
			e2:SetCategory(CATEGORY_REMOVE)
			e2:SetType(EFFECT_TYPE_IGNITION)
			e2:SetRange(LOCATION_MZONE)
			e2:SetCountLimit(1)
			e2:SetTarget(c6621.rmtg2)
			e2:SetOperation(c6621.rmop2)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			rc:RegisterEffect(e2)
			rc:RegisterFlagEffect(6621,RESET_EVENT+0x1fe0000,0,1)
		end
		rc=eg:GetNext()
	end
end
function c6621.rmtg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp)  and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c6621.rmop1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function c6621.rmtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_HAND,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_HAND)
end
function c6621.rmop2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_HAND,nil)
	if g:GetCount()==0 then return end
	local rg=g:RandomSelect(tp,1)
	local tc=rg:GetFirst()
	Duel.Remove(tc,POS_FACEDOWN,REASON_EFFECT)
	tc:RegisterFlagEffect(6621,RESET_EVENT+0x1fe0000,0,1)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetLabelObject(tc)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	e1:SetCondition(c6621.retcon)
	e1:SetOperation(c6621.retop)
	Duel.RegisterEffect(e1,tp)
end
function c6621.retcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffect(6621)==0 then
		e:Reset()
		return false
	else
		return Duel.GetTurnPlayer()==1-tp
	end
end
function c6621.retop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.SendtoHand(tc,1-tp,REASON_EFFECT)
end