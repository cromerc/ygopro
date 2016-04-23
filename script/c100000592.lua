--ダークネス ２
function c100000592.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c100000592.cost2)
	e1:SetTarget(c100000592.destg2)
	e1:SetOperation(c100000592.desop)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_NO_TURN_RESET+EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_F)
	e2:SetCode(EVENT_CHAIN_END)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c100000592.condition)
	e2:SetCost(c100000592.cost)
	e2:SetTarget(c100000592.destg)
	e2:SetOperation(c100000592.desop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c100000592.con)
	e3:SetTarget(c100000592.tg)
	e3:SetOperation(c100000592.op)
	c:RegisterEffect(e3)
end
function c100000592.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():GetFlagEffect(100000592)==0 end
	e:GetHandler():RegisterFlagEffect(100000592,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c100000592.destg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return true end
	if Duel.GetMatchingGroupCount(c100000592.filter,tp,LOCATION_ONFIELD,0,nil,100000594)==0
		or Duel.GetMatchingGroupCount(c100000592.filter,tp,LOCATION_ONFIELD,0,nil,100000595)==0
		then return end
	if Duel.GetFlagEffect(tp,100000591)==0 and Duel.GetFlagEffect(tp,100000593)==0 
		then Duel.RegisterFlagEffect(tp,100000592,RESET_PHASE+PHASE_END,0,1) 
		e:GetHandler():RegisterFlagEffect(100000597,RESET_EVENT+0x1fe0000,0,1)
		end
	if Duel.GetFlagEffect(tp,100000592)~=0 then 
		e:SetCategory(CATEGORY_ATKCHANGE)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	end
end
function c100000592.filter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c100000592.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000592.filter,tp,LOCATION_ONFIELD,0,1,nil,100000594)
		and Duel.IsExistingMatchingCard(c100000592.filter,tp,LOCATION_ONFIELD,0,1,nil,100000595)
		and Duel.IsExistingMatchingCard(c100000591.filter,tp,LOCATION_ONFIELD,0,1,nil,100000590)
		and e:GetHandler():GetFlagEffect(100000592)==0 
end
function c100000592.cost(e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then return true end
		if Duel.GetFlagEffect(tp,100000591)==0 and Duel.GetFlagEffect(tp,100000593)==0 
		then Duel.RegisterFlagEffect(tp,100000592,RESET_PHASE+PHASE_END,0,1) end
end
function c100000592.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return true end
	if Duel.GetFlagEffect(tp,100000592)~=0 then 
		e:SetCategory(CATEGORY_ATKCHANGE)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
		e:GetHandler():RegisterFlagEffect(100000597,RESET_EVENT+0x1fe0000,0,1)
	end
end
function c100000592.desop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,100000592)==0 and 
	 Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil)
	then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		e1:SetValue(1000)
		tc:RegisterEffect(e1)
	end
end
function c100000592.con(e,tp,eg,ep,ev,re,r,rp)
	local code=re:GetHandler():GetCode()
	return e:GetHandler():GetFlagEffect(100000597)~=0 and re and re:GetHandler()~=e:GetHandler() 
		and (code==100000591 or code==100000592 or code==100000593)and re:GetActiveType()==TYPE_CONTINUOUS+TYPE_TRAP 
end
function c100000592.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c100000592.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		e1:SetValue(1000)
		tc:RegisterEffect(e1)
	end
end