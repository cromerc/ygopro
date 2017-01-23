--Aria from Beyond
function c511000146.initial_effect(c)
	--copy spell
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0x1e1,0x1e1)
	e1:SetTarget(c511000146.target)
	e1:SetOperation(c511000146.operation)
	c:RegisterEffect(e1)
end
function c511000146.filter(c,e,tp,eg,ep,ev,re,r,rp)
	local te=c:GetActivateEffect()
	if not te then return end
	local cost=te:GetCost()
	local target=te:GetTarget()
	return c:GetType()==0x2 and (not cost or cost(te,tp,eg,ep,ev,re,r,rp,0) or not cost(te,tp,eg,ep,ev,re,r,rp,0)) 
		and (not target or target(te,tp,eg,ep,ev,re,r,rp,0))
end
function c511000146.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c511000146.filter(chkc,tp,eg,ep,ev,re,r,rp) end
	if chk==0 then return Duel.IsExistingTarget(c511000146.filter,tp,LOCATION_REMOVED,0,1,nil,e,tp,eg,ep,ev,re,r,rp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tc=Duel.SelectTarget(tp,c511000146.filter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp,eg,ep,ev,re,r,rp):GetFirst()
	local te=tc:GetActivateEffect()
	local tg=te:GetTarget()
	e:SetLabelObject(te)
	Duel.ClearTargetCard()
	tc:CreateEffectRelation(e)
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
end
function c511000146.operation(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
	if not te:GetHandler():IsRelateToEffect(e) then return end
	if not te then return end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
end