--Infinity Wall
function c511000979.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000979.condition)
	e1:SetOperation(c511000979.operation)
	c:RegisterEffect(e1)
end
function c511000979.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x3013)
end
function c511000979.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000979.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511000979.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetOperation(c511000979.negop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)	
end
function c511000979.cfilter2(c,tp)
	return c:IsOnField() and c:IsControler(tp)
end
function c511000979.negop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsChainNegatable(ev) then return end
	if re:IsHasCategory(CATEGORY_NEGATE)
		and Duel.GetChainInfo(ev-1,CHAININFO_TRIGGERING_EFFECT):IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	if ex and tg~=nil and tc+tg:FilterCount(c511000979.cfilter2,nil,tp)-tg:GetCount()>0 then
		Duel.NegateEffect(ev)
	end
end
