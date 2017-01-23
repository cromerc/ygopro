--Dimension Trap
function c511000952.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000952.cost)
	e1:SetTarget(c511000952.target)
	e1:SetOperation(c511000952.activate)
	c:RegisterEffect(e1)
end
function c511000952.filter(c,tp,eg,ep,ev,re,r,rp)
	local te=c:GetActivateEffect()
	if not te then return false end
	local cost=te:GetCost()
	local target=te:GetTarget()
	return c:IsType(TYPE_TRAP) and c:IsAbleToRemoveAsCost() and (not cost or cost(te,tp,eg,ep,ev,re,r,rp,0) or not cost(te,tp,eg,ep,ev,re,r,rp,0))
		and (not target or target(te,tp,eg,ep,ev,re,r,rp,0))
end
function c511000952.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511000952.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_MZONE,0,1,nil)
			and Duel.IsExistingMatchingCard(c511000952.filter,tp,LOCATION_GRAVE,0,1,nil,tp,eg,ep,ev,re,r,rp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToRemoveAsCost,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c511000952.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	g1:Merge(g2)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
	local tc=g2:GetFirst()
	local tpe=tc:GetType()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_TYPE)
	e1:SetValue(tpe)
	e1:SetReset(RESET_EVENT+0x1fc0000)
	c:RegisterEffect(e1)
	if bit.band(tpe,TYPE_FIELD)~=0 then
		local of=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
		if of then Duel.Destroy(of,REASON_RULE) end
		of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
		if of and Duel.Destroy(of,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
		Duel.MoveSequence(c,5)
	end
	local te=tc:GetActivateEffect()
	c511000952[Duel.GetCurrentChain()]=te
	Duel.ClearTargetCard()
	local tg=te:GetTarget()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
end
function c511000952.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local te=c511000952[Duel.GetCurrentChain()]
	if not te then return end
	local tpe=te:GetHandler():GetType()
	if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
		c:CancelToGrave(false)
	else
		c:CancelToGrave(true)
		local code=te:GetHandler():GetOriginalCode()
		c:CopyEffect(code,RESET_EVENT+0x1fc0000,1)
	end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
end
