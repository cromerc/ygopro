--Clock Knight No. 12
function c511002118.initial_effect(c)
	--coin
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89718302,0))
	e1:SetCategory(CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511002118.tg)
	e1:SetOperation(c511002118.op)
	c:RegisterEffect(e1)
	--coin
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_TOSS_COIN_NEGATE)
	e2:SetCondition(c511002118.coincon)
	e2:SetOperation(c511002118.coinop)
	c:RegisterEffect(e2)
end
function c511002118.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c511002118.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local res=Duel.TossCoin(tp,1)
		if res==1 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(1200)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e1)
		else
			Duel.Destroy(c,REASON_EFFECT)
		end
	end
end
function c511002118.cfilter(c)
	return c:IsFaceup() and c:IsCode(511002118)
end
function c511002118.coincon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and e:GetHandler():GetFlagEffect(511002118)==0 
		and Duel.IsExistingMatchingCard(c511002118.cfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c511002118.coinop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(511002118)~=0 then return end
	if Duel.SelectYesNo(tp,aux.Stringid(36562627,0)) then
		Duel.Hint(HINT_CARD,0,511002118)
		e:GetHandler():RegisterFlagEffect(511002118,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		Duel.TossCoin(tp,ev)
	end
end
