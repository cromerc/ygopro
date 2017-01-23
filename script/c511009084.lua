--Double Exposure
function c511009084.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(95100770,0))
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCost(c511009084.cost)
	e4:SetTarget(c511009084.tg1)
	e4:SetOperation(c511009084.op1)
	c:RegisterEffect(e4)
	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(97567736,1))
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCost(c511009084.cost)
	e5:SetTarget(c511009084.tg2)
	e5:SetOperation(c511009084.op2)
	c:RegisterEffect(e5)
end
function c511009084.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(511009084)==0 end
	e:GetHandler():RegisterFlagEffect(511009084,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c511009084.filter1(c,tp)
	return c:IsFaceup() and Duel.IsExistingTarget(c511009084.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,c,c:GetCode()) and c:IsLevelBelow(6)
end
function c511009084.filter2(c,code)
	return c:IsFaceup() and c:IsCode(code) and c:IsLevelBelow(6) 
end
function c511009084.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(c511009084.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g1=Duel.SelectTarget(tp,c511009084.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511009084.filter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst(),g1:GetFirst():GetCode())
end
function c511009084.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc1=g:GetFirst()
	local tc2=g:GetNext()
	if tc1:IsRelateToEffect(e) and tc1:IsFaceup() and tc2:IsRelateToEffect(e) and tc2:IsFaceup() then
		local lv=tc1:GetLevel()+tc2:GetLevel()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL_FINAL)
		e1:SetValue(tc1:GetLevel()*2)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc1:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CHANGE_LEVEL_FINAL)
		e2:SetValue(tc2:GetLevel()*2)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc2:RegisterEffect(e2)
	end
end
function c511009084.filterB1(c,tp)
	return c:IsFaceup() and Duel.IsExistingTarget(c511009084.filterB2,c:GetControler(),LOCATION_MZONE,0,1,c,c:GetCode()) 
end
function c511009084.filterB2(c,code)
	return c:IsFaceup() and not c:IsCode(code) 
end
function c511009084.tg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(c511009084.filterB1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g1=Duel.SelectTarget(tp,c511009084.filterB1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511009084.filterB2,g1:GetFirst():GetControler(),LOCATION_MZONE,0,1,1,g1:GetFirst(),g1:GetFirst():GetCode())
end
function c511009084.op2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc1=g:GetFirst()
	local tc2=g:GetNext()
	if tc1:IsRelateToEffect(e) and tc1:IsFaceup() and tc2:IsRelateToEffect(e) and tc2:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(tc1:GetCode())
		tc2:RegisterEffect(e1)
	end
end