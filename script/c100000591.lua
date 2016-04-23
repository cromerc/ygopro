--ダークネス １
function c100000591.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c100000591.cost2)
	e1:SetTarget(c100000591.destg2)
	e1:SetOperation(c100000591.desop)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_NO_TURN_RESET+EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_F)
	e2:SetCode(EVENT_CHAIN_END)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c100000591.condition)
	e2:SetCost(c100000591.cost)
	e2:SetTarget(c100000591.destg)
	e2:SetOperation(c100000591.desop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c100000591.con)
	e3:SetTarget(c100000591.tg)
	e3:SetOperation(c100000591.op)
	c:RegisterEffect(e3)
end
function c100000591.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():GetFlagEffect(100000591)==0 end
	e:GetHandler():RegisterFlagEffect(100000591,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	
end
function c100000591.destg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetControler()~=tp and chkc:IsOnField() and chkc:IsDestructable() end
	if chk==0 then return true end
	if Duel.GetMatchingGroupCount(c100000591.filter,tp,LOCATION_ONFIELD,0,nil,100000594)==0
		or Duel.GetMatchingGroupCount(c100000591.filter,tp,LOCATION_ONFIELD,0,nil,100000595)==0
		then return end
	if Duel.GetFlagEffect(tp,100000592)==0 and Duel.GetFlagEffect(tp,100000593)==0 
		then Duel.RegisterFlagEffect(tp,100000591,RESET_PHASE+PHASE_END,0,1) 
		e:GetHandler():RegisterFlagEffect(100000596,RESET_EVENT+0x1fe0000,0,1)
		end
		
	if Duel.GetFlagEffect(tp,100000591)~=0 then 
		e:SetCategory(CATEGORY_DESTROY)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	end
end
function c100000591.filter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c100000591.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000591.filter,tp,LOCATION_ONFIELD,0,1,nil,100000594)
		and Duel.IsExistingMatchingCard(c100000591.filter,tp,LOCATION_ONFIELD,0,1,nil,100000595)
		and Duel.IsExistingMatchingCard(c100000591.filter,tp,LOCATION_ONFIELD,0,1,nil,100000590)
		and e:GetHandler():GetFlagEffect(100000591)==0 
end
function c100000591.cost(e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then return true end
		if Duel.GetFlagEffect(tp,100000592)==0 and Duel.GetFlagEffect(tp,100000593)==0 
		then Duel.RegisterFlagEffect(tp,100000591,RESET_PHASE+PHASE_END,0,1) end
end
function c100000591.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetControler()~=tp and chkc:IsOnField() and chkc:IsDestructable() end
	if chk==0 then return true end
	if Duel.GetFlagEffect(tp,100000591)~=0 then 
		e:SetCategory(CATEGORY_DESTROY)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
		e:GetHandler():RegisterFlagEffect(100000596,RESET_EVENT+0x1fe0000,0,1)
	end
end
function c100000591.desop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,100000591)==0 and 
	 Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,nil) 
	then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c100000591.con(e,tp,eg,ep,ev,re,r,rp)
	local code=re:GetHandler():GetCode()
	return e:GetHandler():GetFlagEffect(100000596)~=0 and re and re:GetHandler()~=e:GetHandler() 
		and (code==100000591 or code==100000592 or code==100000593)and re:GetActiveType()==TYPE_CONTINUOUS+TYPE_TRAP 
end
function c100000591.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetControler()~=tp and chkc:IsOnField() and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c100000591.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end