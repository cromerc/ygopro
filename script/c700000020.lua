--Scripted by Eerie Code
--Abyss Prop - Escape Stage Coach
function c700000020.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c700000020.condition)
	e2:SetTarget(c700000020.target)
	e2:SetOperation(c700000020.operation)
	c:RegisterEffect(e2)
end
function c700000020.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_BATTLE 
end
function c700000020.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x10ec)
end
function c700000020.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c700000020.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c700000020.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SelectTarget(tp,c700000020.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c700000020.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_SINGLE)
		e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e5:SetRange(LOCATION_MZONE)
		e5:SetCode(EFFECT_IMMUNE_EFFECT)
		e5:SetValue(c700000020.efilter)
		e5:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e5)
	end
end
function c700000020.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
