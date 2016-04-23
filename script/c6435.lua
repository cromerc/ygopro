--Scripted by Eerie Code
--PSYFrame Lord Omega
function c6435.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--Banish
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6435,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(TIMING_MAIN_END,TIMING_MAIN_END)
	e1:SetCountLimit(1)
	e1:SetCondition(c6435.rmcon)
	e1:SetTarget(c6435.rmtg)
	e1:SetOperation(c6435.rmop)
	c:RegisterEffect(e1)
	--To Grave
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(6435,1))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCountLimit(1)
	e3:SetCondition(c6435.tgcon)
--  e3:SetCost(c6435.tgcost)
	e3:SetTarget(c6435.tgtg)
	e3:SetOperation(c6435.tgop)
	c:RegisterEffect(e3)
	--To Hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(6435,2))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c6435.thtg)
	e2:SetOperation(c6435.thop)
	c:RegisterEffect(e2)
end

function c6435.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_MAIN1 or ph==PHASE_MAIN2 and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0
end
function c6435.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local pre=e:GetHandler():GetPreviousControler()
	Duel.SetTargetPlayer(1-pre)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-pre,LOCATION_HAND)
end
function c6435.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetFieldGroup(p,LOCATION_HAND,0)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(p,1)
	local tc=sg:GetFirst()
	local rg=Group.FromCards(c,tc)
	Duel.Remove(rg,0,REASON_EFFECT+REASON_TEMPORARY)
	rg:KeepAlive()
	tc:RegisterFlagEffect(6435,RESET_EVENT+0x1fe0000,0,0)
	c:RegisterFlagEffect(6435,RESET_EVENT+0x1fe0000,0,0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
	e1:SetCountLimit(1)
	e1:SetLabelObject(rg)
	e1:SetCondition(c6435.retcon)
	e1:SetOperation(c6435.retop)
	Duel.RegisterEffect(e1,tp)
end
function c6435.retcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c6435.retop(e,tp,eg,ep,ev,re,r,rp)
	local tg=e:GetLabelObject()
	local tc=tg:GetFirst()
	while tc do
		if tc==e:GetHandler() then
			Duel.ReturnToField(tc)
		else
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
		end
		tc=tg:GetNext()
	end
	e:Reset()
end

function c6435.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c6435.tgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,6436)==0 end
	Duel.RegisterFlagEffect(tp,6436,RESET_PHASE+PHASE_END,0,1)
end
function c6435.tgfilter(c)
	return c:IsFaceup()
end
function c6435.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and c6435.tgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c6435.tgfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,c6435.tgfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c6435.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(tc,REASON_EFFECT+REASON_RETURN)
	end 
end

function c6435.thfil(c)
	return c:IsAbleToDeck()
end
function c6435.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c6435.thfil(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c6435.thfil,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,e:GetHandler()) and e:GetHandler():IsAbleToDeck() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c6435.thfil,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c6435.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(e:GetHandler(),nil,1,REASON_EFFECT)
		Duel.SendtoDeck(tc,nil,1,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end