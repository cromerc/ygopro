--Fog Castle (Anime)
--scripted by Keddy
function c513000125.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTarget(c513000125.destg)
	e2:SetValue(c513000125.desval)
	e2:SetOperation(c513000125.desop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ADJUST)
	e3:SetRange(LOCATION_SZONE)
	e3:SetOperation(c513000125.chkop)
	c:RegisterEffect(e3)
	--salvage
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(111215001,0))
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCondition(c513000125.thcon)
	e4:SetCost(c513000125.thcost)
	e4:SetTarget(c513000125.thtg)
	e4:SetOperation(c513000125.thop)
	c:RegisterEffect(e4)
end
function c513000125.dfilter(c,tp)
	return c:IsControler(tp) and c:IsReason(REASON_BATTLE)
end
function c513000125.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c513000125.dfilter,nil,tp)
	if chk==0 then return g:GetCount()>0 end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return Duel.SelectYesNo(tp,aux.Stringid(40945356,0))
end
function c513000125.desval(e,c)
	return c:IsControler(e:GetHandlerPlayer()) and c:IsReason(REASON_BATTLE)
end
function c513000125.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local nseq=0
	if s==1 then nseq=0
	elseif s==2 then nseq=1
	elseif s==4 then nseq=2
	elseif s==8 then nseq=3
	else nseq=4 end
	Duel.MoveSequence(tc,nseq)
	c:AddCounter(0x1110,1)
	c:ResetEffect(RESET_DISABLE,RESET_EVENT)
end
function c513000125.chkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
 	if c:GetCounter(0x1110)>0 and c:GetFlagEffect(513000125)~=c:GetCounter(0x1110) then
		if 5-c:GetCounter(0x1110)<Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0) then
			local ct=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)+c:GetCounter(0x1110)-5
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_MZONE,0,ct,ct,nil)
			Duel.SendtoGrave(g,REASON_RULE)
		end
		c:ResetEffect(RESET_DISABLE,RESET_EVENT)
		for i=1,c:GetCounter(0x1110) do
			c:RegisterFlagEffect(513000125,RESET_EVENT+0x1ff0000,0,1)
		end
		local dis=Duel.SelectDisableField(tp,c:GetCounter(0x1110),LOCATION_MZONE,0,0)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_FZONE)
		e1:SetCode(EFFECT_DISABLE_FIELD)
		e1:SetOperation(c513000125.disop)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		e1:SetLabel(dis)
		c:RegisterEffect(e1)
	end
end
function c513000125.disop(e,tp)
	return e:GetLabel()
end
function c513000125.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0x1110)>=5
end
function c513000125.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if chk==0 then return hg:GetCount()>0 and hg:FilterCount(Card.IsAbleToGraveAsCost,nil)==hg:GetCount()
		and e:GetHandler():IsAbleToGraveAsCost() end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	g:AddCard(e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c513000125.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,LOCATION_GRAVE,0,4,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,LOCATION_GRAVE,0,4,4,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,4,0,0)
end
function c513000125.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_BP)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
		e1:SetTargetRange(1,0)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
