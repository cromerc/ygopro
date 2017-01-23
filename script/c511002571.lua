--Tachyon Unit
function c511002571.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCost(c511002571.cost)
	e1:SetTarget(c511002571.target)
	e1:SetOperation(c511002571.activate)
	c:RegisterEffect(e1)
end
function c511002571.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c511002571.filter(c,tp,eg,ep,ev,re,r,rp)
	if not c:IsCode(88177324) and not c:IsCode(68396121) then return false end
	if c:IsFacedown() then return false end
	local e=Effect.CreateEffect(c)
	e:SetType(EFFECT_TYPE_SINGLE)
	e:SetCode(511002571)
	c:RegisterEffect(e)
	local cost=c.negcost
	local tg=c.negtg
	return cost and (not tg or tg(e,tp,eg,ep,ev,re,r,rp,0)) and c.negop
end
function c511002571.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511002571.filter(chkc,tp,eg,ep,ev,re,r,rp) end
	if chk==0 then return Duel.IsExistingTarget(c511002571.filter,tp,LOCATION_MZONE,0,1,nil,tp,eg,ep,ev,re,r,rp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
	Duel.SelectTarget(tp,c511002571.filter,tp,LOCATION_MZONE,0,1,1,nil,tp,eg,ep,ev,re,r,rp)
end
function c511002571.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local te=Effect.CreateEffect(tc)
		te:SetType(EFFECT_TYPE_SINGLE)
		te:SetCode(511002571)
		tc:RegisterEffect(te)
		local tg=tc.negtg
		local op=tc.negop
		if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
		Duel.BreakEffect()
		tc:CreateEffectRelation(te)
		Duel.BreakEffect()
		local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
		if g then
			local etc=g:GetFirst()
			while etc do
				etc:CreateEffectRelation(te)
				etc=g:GetNext()
			end
		end
		if op then op(te,tp,eg,ep,ev,re,r,rp) end
		tc:ReleaseEffectRelation(te)
		if etc then	
			etc=g:GetFirst()
			while etc do
				etc:ReleaseEffectRelation(te)
				etc=g:GetNext()
			end
		end
	end
end
