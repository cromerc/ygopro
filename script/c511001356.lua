--Hero's Guild
function c511001356.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--send to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001356,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511001356.target)
	e2:SetOperation(c511001356.operation)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511001356,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(511001356)
	e3:SetCondition(c511001356.thcon)
	e3:SetTarget(c511001356.thtg)
	e3:SetOperation(c511001356.thop)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(5851097,0))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(511001357)
	e4:SetCondition(c511001356.descon)
	e4:SetTarget(c511001356.destg)
	e4:SetOperation(c511001356.desop)
	c:RegisterEffect(e4)
end
function c511001356.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) and Duel.IsPlayerCanDiscardDeck(1-tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,PLAYER_ALL,1)
end
function c511001356.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or not Duel.IsPlayerCanDiscardDeck(tp,1) or not Duel.IsPlayerCanDiscardDeck(1-tp,1) then return end
	local tc1=Duel.GetDecktopGroup(tp,1):GetFirst()
	local tc2=Duel.GetDecktopGroup(1-tp,1):GetFirst()
	Duel.DiscardDeck(tp,1,REASON_EFFECT)
	Duel.DiscardDeck(1-tp,1,REASON_EFFECT)
	local v=0
	if tc1 and tc1:IsRace(RACE_WARRIOR) and tc1:IsLocation(LOCATION_GRAVE) and tc1:IsAbleToHand() and Duel.SelectYesNo(tp,aux.Stringid(4179255,0)) then
		v=v+1
	end
	if tc2 and tc2:IsRace(RACE_WARRIOR) and tc2:IsLocation(LOCATION_GRAVE) and tc1:IsAbleToHand() and Duel.SelectYesNo(1-tp,aux.Stringid(4179255,0)) then
		v=v+2
	end
	if v==0 then return end
	local p=0
	local g=nil
	if v==1 then
		g=tc1
		p=tc1:GetControler()
	elseif v==2 then
		g=tc2
		p=tc2:GetControler()
	else
		g=Group.FromCards(tc1,tc2)
		p=PLAYER_ALL
	end
	Duel.RaiseEvent(g,511001356,e,REASON_EFFECT,tp,p,v)
end
function c511001356.thcon(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentChain()==0 then return true end
	for i=1,Duel.GetCurrentChain() do
		local te=Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
		local tc=te:GetHandler()
		if tc~=e:GetHandler() and tc:IsControler(tp) and tc:GetOriginalCode()==511001356 then
			return false
		end
	end
	return true
end
function c511001356.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,eg,eg:GetCount(),0,0)
end
function c511001356.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=eg:Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()<=0 then return end
	Duel.SendtoHand(g,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
	Duel.ConfirmCards(tp,g)
	Duel.RaiseSingleEvent(e:GetHandler(),511001357,e,0,tp,0,0)
end
function c511001356.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsStatus(STATUS_ACTIVATED)
end
function c511001356.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsRelateToEffect(e) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,c,1,0,0)
end
function c511001356.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.Destroy(c,REASON_EFFECT)
	end
end
