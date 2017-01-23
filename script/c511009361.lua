--Raidraptor - Silent Roar
function c511009361.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(c511009361.condition)
	e1:SetTarget(c511009361.target)
	e1:SetOperation(c511009361.activate)
	c:RegisterEffect(e1)
end
function c511009361.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xba)
end
function c511009361.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsChainNegatable(ev) and aux.damcon1(e,tp,eg,ep,ev,re,r,rp) and Duel.IsExistingMatchingCard(c511009361.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511009361.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c511009361.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
