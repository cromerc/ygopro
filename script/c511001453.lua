--Misdirection Wing
function c511001453.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001453.condition)
	e1:SetTarget(c511001453.target)
	e1:SetOperation(c511001453.activate)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCost(c511001453.cost)
	e2:SetTarget(c511001453.target)
	e2:SetOperation(c511001453.activate)
	c:RegisterEffect(e2)
end
function c511001453.cfilter(c)
	return c:GetSequence()<5
end
function c511001453.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==1
		and not Duel.IsExistingMatchingCard(c511001453.cfilter,tp,LOCATION_SZONE,0,1,e:GetHandler())
end
function c511001453.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001453.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(800)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_ONFIELD,nil)
		local tg=g:GetFirst()
		while tg do
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tg:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tg:RegisterEffect(e2)
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
			e3:SetRange(LOCATION_ONFIELD)
			e3:SetCode(EVENT_CHAIN_ACTIVATING)
			e3:SetOperation(c511001453.disop)
			e3:SetReset(RESET_EVENT+0x1fc0000+RESET_PHASE+PHASE_END)
			tg:RegisterEffect(e3)
			tg=g:GetNext()
		end
	end
end
function c511001453.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	Duel.NegateEffect(ev)
end
function c511001453.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToRemoveAsCost() and Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_ONFIELD,0,2,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemoveAsCost,tp,LOCATION_ONFIELD,0,2,2,c)	
	g:AddCard(c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
