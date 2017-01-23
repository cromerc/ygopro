--Chaos Barrier
function c511001421.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001421.target)
	e1:SetOperation(c511001421.activate)
	c:RegisterEffect(e1)
end
function c511001421.filter(c,tp)
	return c:IsFaceup() and (c:IsSetCard(0x1048) or c:IsSetCard(0x1073) or c:IsCode(511000296))
		and Duel.IsExistingTarget(c511001421.filter2,tp,LOCATION_MZONE,0,1,c,c:GetCode())
end
function c511001421.filter2(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c511001421.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c:IsControler(tp) and c511001421.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511001421.filter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g1=Duel.SelectTarget(tp,c511001421.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g2=Duel.SelectTarget(tp,c511001421.filter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst(),g1:GetFirst():GetCode())
end
function c511001421.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not tg or tg:FilterCount(Card.IsRelateToEffect,nil,e)~=2 
		or tg:FilterCount(Card.IsControler,nil,tp)~=2 then return end
	local tc=tg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
		e1:SetValue(aux.imval1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_CANNOT_REMOVE)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		local e3=e2:Clone()
		e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		tc:RegisterEffect(e3)
		tc=tg:GetNext()
	end
end
