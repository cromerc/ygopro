--U.A. Penalty Box
function c5779.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c5779.rmcon1)
	e1:SetTarget(c5779.rmtg1)
	e1:SetOperation(c5779.rmop)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c5779.rmcon2)
	e2:SetCost(c5779.rmcost)
	e2:SetTarget(c5779.rmtg2)
	e2:SetOperation(c5779.rmop)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCost(c5779.thcost)
	e3:SetTarget(c5779.thtg)
	e3:SetOperation(c5779.thop)
	c:RegisterEffect(e3)
end
function c5779.rmchk(e,tp,eg,ep,ev,re,r,rp)
	return Duel.CheckEvent(EVENT_BATTLE_START)
		and c5779.rmcon2(e,tp,eg,ep,ev,re,r,rp)
		and c5779.rmcost(e,tp,eg,ep,ev,re,r,rp,0)
		and c5779.rmtg2(e,tp,eg,ep,ev,re,r,rp,0)
end
function c5779.rmcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE
		or c5779.rmchk(e,tp,eg,ep,ev,re,r,rp)
end
function c5779.rmtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if c5779.rmchk(e,tp,eg,ep,ev,re,r,rp) then
		e:SetCategory(CATEGORY_REMOVE)
		c5779.rmcost(e,tp,eg,ep,ev,re,r,rp,1)
		c5779.rmtg2(e,tp,eg,ep,ev,re,r,rp,1)
		e:GetHandler():RegisterFlagEffect(0,RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(5779,0))
	else
		e:SetCategory(0)
	end
end
function c5779.rmcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=Duel.GetAttacker()
	local bc=Duel.GetAttackTarget()
	if not bc then return false end
	if c:IsControler(1-tp) then bc,c=c,bc end
	e:SetLabelObject(bc)
	return c:IsFaceup() and c:IsSetCard(0xb2)
end
function c5779.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,5779)==0 end
	Duel.RegisterFlagEffect(tp,5779,RESET_PHASE+PHASE_END,0,1)
end
function c5779.rmtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetLabelObject():IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetLabelObject(),1,0,0)
end
function c5779.rmop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or Duel.GetFlagEffect(tp,5779)==0 then return end
	local tc=e:GetLabelObject()
	if tc:IsRelateToBattle() and Duel.Remove(tc,tc:GetPosition(),REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
		e1:SetCountLimit(1)
		e1:SetLabel(fid)
		e1:SetLabelObject(tc)
		e1:SetCondition(c5779.retcon)
		e1:SetOperation(c5779.retop)
		Duel.RegisterEffect(e1,tp)
		tc:SetTurnCounter(0)
		tc:RegisterFlagEffect(5779,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,2,fid)
	end
end
function c5779.retcon(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()==tp then return false end
	local tc=e:GetLabelObject()
	if tc:GetFlagEffectLabel(5779)==e:GetLabel() then
		return true
	else
		e:Reset()
		return false
	end
end
function c5779.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetLabelObject()
	local ct=c:GetTurnCounter()
	c:SetTurnCounter(ct+1)
	if ct==1 then
		Duel.ReturnToField(e:GetLabelObject())
	end
end
function c5779.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c5779.filter(c)
	return c:IsSetCard(0xb2) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c5779.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c5779.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c5779.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c5779.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
