--Raidraptor - Desperate
function c511002084.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(c511002084.condition)
	e1:SetTarget(c511002084.target)
	e1:SetOperation(c511002084.activate)
	c:RegisterEffect(e1)
end
function c511002084.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xba)
end
function c511002084.condition(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsChainDisablable(ev) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tc>0 and Duel.IsExistingMatchingCard(c511002084.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511002084.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511002084.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
	Duel.Draw(tp,1,REASON_EFFECT)
end
