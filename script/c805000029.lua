--トリック・デーモン
function c805000029.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(805000029,1))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(c805000029.thcon)
	e1:SetCost(c805000029.spcost)
	e1:SetTarget(c805000029.thtg)
	e1:SetOperation(c805000029.thop)
	c:RegisterEffect(e1)
end
function c805000029.thcon(e,tp,eg,ep,ev,re,r,rp)
	return (e:GetHandler():IsReason(REASON_EFFECT) and not e:GetHandler():IsReason(REASON_RETURN)) or e:GetHandler():IsReason(REASON_BATTLE)
end
function c805000029.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,805000029)==0 end
	Duel.RegisterFlagEffect(tp,805000029,RESET_PHASE+PHASE_END,0,1)
end
function c805000029.filter(c)
	return c:IsSetCard(0x45) and c:GetCode()~=805000029 and c:IsAbleToHand()
end
function c805000029.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_DECK) and c805000029.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c805000029.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c805000029.filter,tp,LOCATION_DECK,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c805000029.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
