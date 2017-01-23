--Magical Sky Mirror
function c511001408.initial_effect(c)
	--copy spell
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001408.target)
	e1:SetOperation(c511001408.operation)
	c:RegisterEffect(e1)
end
function c511001408.filter(c,e,tp,eg,ep,ev,re,r,rp,tid)
	local te=c:GetActivateEffect()
	if not te then return end
	local cost=te:GetCost()
	local target=te:GetTarget()
	return c:GetTurnID()==tid-1 and c:IsPreviousPosition(POS_FACEUP)
		and c:GetType()==0x2 and (not cost or cost(te,1-tp,eg,ep,ev,re,r,rp,0)) and (not target or target(te,tp,eg,ep,ev,re,r,rp,0))
end
function c511001408.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tid=Duel.GetTurnCount()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c511001408.filter(chkc,tp,eg,ep,ev,re,r,rp,tid) end
	if chk==0 then return Duel.IsExistingTarget(c511001408.filter,tp,0,LOCATION_GRAVE,1,nil,e,tp,eg,ep,ev,re,r,rp,tid) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tc=Duel.SelectTarget(tp,c511001408.filter,tp,0,LOCATION_GRAVE,1,1,nil,e,tp,eg,ep,ev,re,r,rp,tid):GetFirst()
	local te=tc:GetActivateEffect()
	local tg=te:GetTarget()
	e:SetLabelObject(te)
	Duel.ClearTargetCard()
	tc:CreateEffectRelation(e)
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
end
function c511001408.operation(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
	if not te:GetHandler():IsRelateToEffect(e) then return end
	if not te then return end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
end
