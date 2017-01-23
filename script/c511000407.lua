--呪い移し
function c511000407.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511000407.condition)
	e1:SetTarget(c511000407.target)
	e1:SetOperation(c511000407.activate)
	c:RegisterEffect(e1)
end
function c511000407.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and rp~=tp and Duel.IsChainNegatable(ev)
end
function c511000407.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c511000407.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	local c=e:GetHandler()
	local tc=re:GetHandler()
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
end
