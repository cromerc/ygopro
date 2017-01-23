--Spirit Coup
function c511002770.initial_effect(c)
	--copy spell
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002770.condition)
	e1:SetTarget(c511002770.target)
	e1:SetOperation(c511002770.activate)
	c:RegisterEffect(e1)
end
function c511002770.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c511002770.filter(c,e,tp,eg,ep,ev,re,r,rp)
	local te=c:GetActivateEffect()
	if not te then return end
	local cost=te:GetCost()
	local target=te:GetTarget()
	return c:IsType(TYPE_TRAP) and (not cost or cost(te,tp,eg,ep,ev,re,r,rp,0) or not cost(te,tp,eg,ep,ev,re,r,rp,0)) 
		and (not target or target(te,tp,eg,ep,ev,re,r,rp,0))
end
function c511002770.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511002770.filter(chkc,tp,eg,ep,ev,re,r,rp) end
	if chk==0 then return Duel.IsExistingTarget(c511002770.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp,eg,ep,ev,re,r,rp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tc=Duel.SelectTarget(tp,c511002770.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,eg,ep,ev,re,r,rp):GetFirst()
	local te=tc:GetActivateEffect()
	local tg=te:GetTarget()
	e:SetLabelObject(te)
	Duel.ClearTargetCard()
	tc:CreateEffectRelation(e)
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
end
function c511002770.activate(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
	if not te:GetHandler():IsRelateToEffect(e) then return end
	if not te then return end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
end
