---Ｅ・ＨＥＲＯ シャドー・ミスト
function c102701.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(102701,0))
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,102701)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c102701.thcon)
	e1:SetCost(c102701.thcos)
	e1:SetTarget(c102701.thtg1)
	e1:SetOperation(c102701.thop1)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(102701,1))
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,102701)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c102701.thcon)
	e2:SetCost(c102701.thcos)
	e2:SetTarget(c102701.thtg2)
	e2:SetOperation(c102701.thop2)
	c:RegisterEffect(e2)
end
function c102701.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return Duel.GetFlagEffect(tp,102701)==0
end
function c102701.thcos(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.GetFlagEffect(tp,102701)==0 end
	Duel.RegisterFlagEffect(tp,102701,RESET_PHASE+PHASE_END,0,1)
end	
function c102701.thfilter1(c)
	return c:IsAbleToHand()
	and c:IsType(TYPE_SPELL) and c:IsType(TYPE_QUICKPLAY)
	and c:IsSetCard(0xb0) 
end
function c102701.thtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingMatchingCard(c102701.thfilter1,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(tp,CATEGORY_TOHAND+CATEGORY_SEARCH,nil,1,tp,LOCATION_DECK)
end	
function c102701.thop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c102701.thfilter1,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 then
		local tg=g:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		Duel.ShuffleHand(tp)
	end
end	
function c102701.thfilter2(c)
	return c:IsAbleToHand()
	and c:IsSetCard(0x8)
	and c:GetCode()~=102701
end
function c102701.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingMatchingCard(c102701.thfilter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(tp,CATEGORY_TOHAND+CATEGORY_SEARCH,nil,1,tp,LOCATION_DECK)
end	
function c102701.thop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c102701.thfilter2,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 then
		local tg=g:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		Duel.ShuffleHand(tp)
	end
end	
