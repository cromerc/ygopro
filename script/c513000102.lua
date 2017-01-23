--Destiny Activator
function c513000102.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTarget(c513000102.target)
	e1:SetOperation(c513000102.activate)
	c:RegisterEffect(e1)
end
function c513000102.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end
function c513000102.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local p,val=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.DiscardDeck(p,val,REASON_EFFECT)>0 then
		local tc=Duel.GetOperatedGroup():GetFirst()
		local tpe=0
		if tc:IsType(TYPE_MONSTER) then
			tpe=TYPE_MONSTER
		elseif tc:IsType(TYPE_SPELL) then
			tpe=TYPE_SPELL
		else
			tpe=TYPE_TRAP
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_DRAW)
		e1:SetLabel(tpe)
		e1:SetRange(LOCATION_SZONE)
		e1:SetCondition(c513000102.drcon)
		e1:SetOperation(c513000102.drop)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
	end
end
function c513000102.drcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()==PHASE_DRAW and eg:GetCount()==1
end
function c513000102.drop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local hg=eg:Filter(Card.IsLocation,nil,LOCATION_HAND)
	local hc=hg:GetFirst()
	if hg:GetCount()==0 then return end
	Duel.ConfirmCards(tp,hg)
	Duel.ShuffleHand(1-tp)
	if hc:IsType(e:GetLabel()) and Duel.Destroy(c,REASON_EFFECT)>0 then
		Duel.SetLP(1-tp,Duel.GetLP(1-tp)/2,REASON_EFFECT)
	end
end
