--Action Card - Encore
function c95000177.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c95000177.condition)
	e1:SetTarget(c95000177.target)
	e1:SetOperation(c95000177.operation)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	c:RegisterEffect(e2)
end
function c95000177.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c95000177.filter(c)
	return c:IsSetCard(0xac1) and c:IsType(TYPE_SPELL) and c:CheckActivateEffect(false,false,false)~=nil and not c:IsType(TYPE_FIELD)
end
function c95000177.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local b1=Duel.IsExistingMatchingCard(c95000177.filter,tp,LOCATION_GRAVE,0,1,nil,tp)
	local op=0
	if b1 then
	op=Duel.SelectOption(tp,aux.Stringid(95000177,0),aux.Stringid(95000177,1))
	else
	op=Duel.SelectOption(tp,aux.Stringid(95000177,1))+1
	end
	if op==0 then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c95000177.filter,tp,0,LOCATION_GRAVE,1,1,nil)
	else
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	end
	e:SetLabel(op)
end
function c95000177.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	if c:IsRelateToEffect(e) and not tc:IsType(TYPE_EQUIP+TYPE_CONTINUOUS)  then
		local tpe=tc:GetType()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetValue(tpe)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		c:RegisterEffect(e1)
		local te=tc:GetActivateEffect()
		local tg=te:GetTarget()
		local op=te:GetOperation()
		e:SetCategory(te:GetCategory())
		e:SetProperty(te:GetProperty())
		Duel.ClearTargetCard()
		if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
		Duel.BreakEffect()
		if op then op(e,tp,eg,ep,ev,re,r,rp) end 
	end
	if c:IsRelateToEffect(e) and tc:IsType(TYPE_EQUIP+TYPE_CONTINUOUS)  then
		local tpe=tc:GetType()
		local code=tc:GetOriginalCode()
		c:CopyEffect(code,nil,1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetValue(tpe)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		c:RegisterEffect(e1)
		local te=tc:GetActivateEffect()
		local tg=te:GetTarget()
		local op=te:GetOperation()
		e:SetCategory(te:GetCategory())
		e:SetProperty(te:GetProperty())
		Duel.ClearTargetCard()
		if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
		Duel.BreakEffect()
		if op then op(e,tp,eg,ep,ev,re,r,rp) end 
		c:CancelToGrave()
	end
	else
		if e:GetHandler():IsRelateToEffect(e) then
			Duel.Destroy(e:GetHandler(),REASON_EFFECT)
		end
	end
end
