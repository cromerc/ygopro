--フラッシュ・エフェクト
function c100000228.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c100000228.condition)
	e1:SetTarget(c100000228.target)
	e1:SetOperation(c100000228.activate)
	c:RegisterEffect(e1)
end
function c100000228.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>=0x08 and ph<=0x20 and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
end
function c100000228.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
end
function c100000228.filter2(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function c100000228.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	local c=e:GetHandler()
	local tc=re:GetHandler()
	if tc:IsRelateToEffect(re) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		e1:SetValue(800)
		tc:RegisterEffect(e1)
	end
	local g=Duel.GetMatchingGroup(c100000228.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=g:GetFirst()
	while sg do
		--disable
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		sg:RegisterEffect(e1)
		sg=g:GetNext()
	end
end
