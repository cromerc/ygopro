---シャドール・ヘッジホッグ
function c501001024.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(501001024,0))
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_FLIP)
	e1:SetCondition(c501001024.thcon1)
	e1:SetCost(c501001024.thcos1)
	e1:SetTarget(c501001024.thtg1)
	e1:SetOperation(c501001024.thop1)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(501001024,1))
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c501001024.thcon2)
	e2:SetCost(c501001024.thcos2)
	e2:SetTarget(c501001024.thtg2)
	e2:SetOperation(c501001024.thop2)
	c:RegisterEffect(e2)
end
function c501001024.thcon1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return Duel.GetFlagEffect(tp,501001024)==0
end
function c501001024.thcos1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.GetFlagEffect(tp,501001024)==0 end
	Duel.RegisterFlagEffect(tp,501001024,RESET_PHASE+PHASE_END,0,1)
end	
function c501001024.thfilter1(c)
	return c:IsAbleToHand()
	and c:IsSetCard(0x9b)
	and (c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP))
end
function c501001024.thtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingMatchingCard(c501001024.thfilter1,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(tp,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(tp,CATEGORY_SEARCH,nil,1,tp,LOCATION_DECK)
end	
function c501001024.thop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c501001024.thfilter1,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 then
		local tg=g:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		Duel.ShuffleHand(tp)
	end
end	
function c501001024.thcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return Duel.GetFlagEffect(tp,501001024)==0
	and c:IsReason(REASON_EFFECT)
	and not c:IsReason(REASON_RETURN)
end
function c501001024.thcos2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.GetFlagEffect(tp,501001024)==0 end
	Duel.RegisterFlagEffect(tp,501001024,RESET_PHASE+PHASE_END,0,1)
end	
function c501001024.thfilter2(c)
	return c:IsAbleToHand()
	and c:IsSetCard(0x9b)
	and c:IsType(TYPE_MONSTER)
	and c:GetCode()~=501001024
end
function c501001024.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingMatchingCard(c501001024.thfilter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(tp,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(tp,CATEGORY_SEARCH,nil,1,tp,LOCATION_DECK)
end	
function c501001024.thop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c501001024.thfilter2,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 then
		local tg=g:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		Duel.ShuffleHand(tp)
	end
end	
