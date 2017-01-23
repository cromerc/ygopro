-- Perfect Pass
-- scripted by: UnknownGuest
function c810000060.initial_effect(c)
	-- target monster
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(810000060,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c810000060.target)
	e1:SetOperation(c810000060.operation)
	c:RegisterEffect(e1)
end
function c810000060.filter(c)
	return c:IsFaceup()
end
function c810000060.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c810000060.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c810000060.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c810000060.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c810000060.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(810000060,0))
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_BATTLED)
		e1:SetCondition(c810000060.atkcon)
		e1:SetOperation(c810000060.atkop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c810000060.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	if a==c then a=Duel.GetAttackTarget() end
	e:SetLabelObject(a)
	return a and a:IsType(TYPE_EFFECT) and a:IsRelateToBattle()
end
function c810000060.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsFacedown() or not tc:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e2)
	local tc1=tc:GetDefense()
	local tc2=e:GetHandler()
	if tc1>tc2:GetAttack() then
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_CHANGE_ATTACK)
		e3:SetValue(tc2:GetAttack()*2)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc2:RegisterEffect(e1)
	end
end
