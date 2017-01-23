--Jurassic Heart
function c511000895.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DISABLE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511000895.condition)
	e1:SetTarget(c511000895.target)
	e1:SetOperation(c511000895.activate)
	c:RegisterEffect(e1)
end
function c511000895.cfilter(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsRace(RACE_DINOSAUR) and c:IsControler(tp)
end
function c511000895.condition(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:GetCount()==1 and re:IsActiveType(TYPE_TRAP) and c511000895.cfilter(tg:GetFirst(),tp) and Duel.IsChainNegatable(ev)
end
function c511000895.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c511000895.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	local e8=Effect.CreateEffect(e:GetHandler())
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_DISABLE)
	e8:SetReset(RESET_EVENT+0x1fe0000)
	re:GetHandler():RegisterEffect(e8,true)
	local e9=Effect.CreateEffect(e:GetHandler())
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetCode(EFFECT_DISABLE_EFFECT)
	e9:SetReset(RESET_EVENT+0x1fe0000)
	re:GetHandler():RegisterEffect(e9,true)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
