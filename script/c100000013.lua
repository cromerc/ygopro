--無限械アイン・ソフ
function c100000013.initial_effect(c)
	--Activate to Grave
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCost(c100000013.cost)
	e1:SetTarget(c100000013.target)
	c:RegisterEffect(e1)
	--your turn
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1)
	e2:SetHintTiming(TIMING_END_PHASE,0)
	e2:SetCondition(c100000013.spcon)
	e2:SetTarget(c100000013.sptg)
	e2:SetOperation(c100000013.spop)
	c:RegisterEffect(e2)
	--opponent's turn
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCountLimit(1)
	e3:SetHintTiming(0,TIMING_END_PHASE)
	e3:SetCondition(c100000013.drcon)
	e3:SetCost(c100000013.drcost)
	e3:SetTarget(c100000013.drtg)
	e3:SetOperation(c100000013.drop)
	c:RegisterEffect(e3)
	--salvage
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(13455953,0))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetCondition(c100000013.thcon)
	e4:SetTarget(c100000013.thtg)
	e4:SetOperation(c100000013.thop)
	c:RegisterEffect(e4)
end
function c100000013.cfilter(c)
	return c:IsFaceup() and c:IsCode(100000012) and c:IsAbleToGraveAsCost()
end
function c100000013.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000013.cfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100000013.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c100000013.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.GetTurnPlayer()==tp and c100000013.sptg(e,tp,eg,ep,ev,re,r,rp,0) and Duel.SelectYesNo(tp,aux.Stringid(65872270,0)) then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e:SetProperty(0)
		e:SetOperation(c100000013.spop)
		c100000013.sptg(e,tp,eg,ep,ev,re,r,rp,1)
	elseif Duel.GetTurnPlayer()~=tp and c100000013.drcost(e,tp,eg,ep,ev,re,r,rp,0) and c100000013.drtg(e,tp,eg,ep,ev,re,r,rp,0) 
		and Duel.SelectYesNo(tp,aux.Stringid(65872270,0)) then
		e:SetCategory(CATEGORY_DRAW)
		e:SetOperation(c100000013.drop)
		e:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		c100000013.drcost(e,tp,eg,ep,ev,re,r,rp,1)
		c100000013.drtg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetCategory(0)
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end
function c100000013.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c100000013.spfilter(c,e,tp)
	return (c:IsSetCard(0x4a) or c:IsCode(74530899) or c:IsCode(8967776)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000013.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c100000013.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) 
		and e:GetHandler():GetFlagEffect(100000013)==0 end
	e:GetHandler():RegisterFlagEffect(100000013,RESET_PHASE+PHASE_END,0,1)
end
function c100000013.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000013.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c100000013.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c100000013.cosfilter(c)
	return (c:IsSetCard(0x4a) or c:IsCode(74530899) or c:IsCode(8967776)) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c100000013.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000013.cosfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c100000013.cosfilter,1,1,REASON_COST+REASON_DISCARD,e:GetHandler())
end
function c100000013.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) and e:GetHandler():GetFlagEffect(100000013)==0 end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	e:GetHandler():RegisterFlagEffect(100000013,RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c100000013.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c100000013.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP)
end
function c100000013.thfilter(c)
	return c:IsCode(100000012) and c:IsAbleToHand()
end
function c100000013.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c100000013.thfilter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c100000013.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c100000013.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
