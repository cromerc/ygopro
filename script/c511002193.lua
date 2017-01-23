--RR Target Flag
function c511002193.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_STANDBY_PHASE,0x1c0)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511002193.target)
	e1:SetOperation(c511002193.operation)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(0)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c511002193.descon)
	e2:SetTarget(c511002193.destg)
	e2:SetOperation(c511002193.desop)
	e2:SetLabel(0)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
function c511002193.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) 
		and Duel.IsPlayerCanDraw(tp,1) end
	e:GetLabelObject():SetLabel(0)
	e:GetLabelObject():SetDescription(0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511002193.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		local td=Duel.GetDecktopGroup(tp,1):GetFirst()
		if td then
			Duel.Draw(tp,1,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,td)
			if td:IsType(TYPE_MONSTER) then
				e:GetLabelObject():SetLabel(TYPE_MONSTER)
				e:GetLabelObject():SetDescription(70)
			elseif td:IsType(TYPE_SPELL) then
				e:GetLabelObject():SetLabel(TYPE_SPELL)
				e:GetLabelObject():SetDescription(71)
			else
				e:GetLabelObject():SetLabel(TYPE_TRAP)
				e:GetLabelObject():SetDescription(72)
			end
			Duel.ShuffleHand(tp)
		end
	end
end
function c511002193.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c511002193.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c511002193.desop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Destroy(e:GetHandler(),REASON_EFFECT)>0 then
		if e:GetLabel()==0 then return end
		local hg=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
		Duel.ConfirmCards(tp,hg)
		local dg=hg:Filter(Card.IsType,nil,e:GetLabel())
		Duel.Destroy(dg,REASON_EFFECT)
		Duel.ShuffleHand(1-tp)
	end
	e:SetDescription(0)
end
