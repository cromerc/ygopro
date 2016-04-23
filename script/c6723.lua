--Scripted by Eerie Code
--Pandeity Monarchs
function c6723.initial_effect(c)
	-- draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6723,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCost(c6723.cost)
	e1:SetTarget(c6723.target)
	e1:SetOperation(c6723.operation)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(6723,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,6723+EFFECT_COUNT_CODE_OATH)
	e2:SetCost(c6723.thcost)
	e2:SetTarget(c6723.thtg)
	e2:SetOperation(c6723.thop)
	c:RegisterEffect(e2)
end
function c6723.cfilter(c)
	return c:IsSetCard(0xbe) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGraveAsCost()
end
function c6723.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6723.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c6723.cfilter,1,1,REASON_COST,e:GetHandler())
end
function c6723.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c6723.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end

function c6723.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c6723.thfil(c)
	return c:IsSetCard(0xbe) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c6723.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		--local g=Duel.GetMatchingGroup(c6723.thfil,tp,LOCATION_DECK,0,nil)
		--return g:GetClassCount(Card.GetCode)>=3
		return Duel.IsExistingMatchingCard(c6723.thfil,tp,LOCATION_DECK,0,3,nil)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,LOCATION_DECK)
end
function c6723.thop(e,tp,eg,ep,ev,re,r,rp)
--  local g=Duel.GetMatchingGroup(c6723.thfil,tp,LOCATION_DECK,0,nil)
--  if g:GetClassCount(Card.GetCode)>=3 then
--	  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
--	  local sg1=g:Select(tp,1,1,nil)
--	  g:Remove(Card.IsCode,nil,sg1:GetFirst():GetCode())
--	  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
--	  local sg2=g:Select(tp,1,1,nil)
--	  g:Remove(Card.IsCode,nil,sg2:GetFirst():GetCode())
--	  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
--	  local sg3=g:Select(tp,1,1,nil)
--	  sg1:Merge(sg2)
--	  sg1:Merge(sg3)
	local sg1=Duel.SelectMatchingCard(tp,c6723.thfil,tp,LOCATION_DECK,0,3,3,nil)
	if sg1:GetCount()==3 then
		Duel.ConfirmCards(1-tp,sg1)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
		local tg=sg1:Select(1-tp,1,1,nil)
		local tc=tg:GetFirst()
		if tc:IsAbleToHand() then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
		else
			Duel.SendtoGrave(tc,REASON_EFFECT)
		end
	end
	Duel.ShuffleDeck(tp)
end