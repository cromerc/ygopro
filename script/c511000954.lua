--Tricolor Illusion
function c511000954.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000954,0))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e3:SetCost(c511000954.descost)
	e3:SetCondition(c511000954.descon)
	e3:SetTarget(c511000954.destg)
	e3:SetOperation(c511000954.desop)
	c:RegisterEffect(e3)
	--reveal
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511000954,1))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_HANDES+CATEGORY_TODECK)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetCondition(c511000954.revcon)
	e4:SetCost(c511000954.revcost)
	e4:SetOperation(c511000954.revop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_PHASE+PHASE_END)
	c:RegisterEffect(e5)
end
function c511000954.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeckAsCost(tp,1) end
	Duel.DiscardDeck(tp,1,REASON_COST)
end
function c511000954.descon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_CHAINING) and e:GetHandler():GetControler()~=tp
end
function c511000954.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDestructable() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c511000954.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
function c511000954.revcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=1
end
function c511000954.revcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,511000954)==0 end
	Duel.RegisterFlagEffect(tp,511000954,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END,0,0)
end
function c511000954.revop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DisableShuffleCheck()
	Duel.ConfirmDecktop(1-tp,1)
	local g=Duel.GetDecktopGroup(1-tp,1)
	local tc=g:GetFirst()
	if tc:IsType(TYPE_SPELL) then
		if tc:IsAbleToHand() then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(tp,tc)
			Duel.BreakEffect()
			Duel.ShuffleHand(1-tp)
		end
	elseif tc:IsType(TYPE_TRAP) then
		Duel.DiscardDeck(1-tp,1,REASON_EFFECT+REASON_REVEAL+REASON_DISCARD)
		local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DISCARD)
		local sg=g:Select(1-tp,1,1,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
	else
		if tc:IsAbleToHand() then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(tp,tc)
			local hg=Duel.SelectMatchingCard(1-tp,Card.IsAbleToDeck,1-tp,LOCATION_HAND,0,1,1,tc)
			Duel.SendtoDeck(hg,nil,0,REASON_EFFECT)
			Duel.BreakEffect()
			Duel.ShuffleHand(1-tp)
		end
	end
end
