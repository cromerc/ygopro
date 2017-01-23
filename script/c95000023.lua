--Numeron Network
function c95000023.initial_effect(c)
    --activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(2)
	e2:SetValue(c95000023.valcon)
	c:RegisterEffect(e2)
	--activate 2
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(95000023,0))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c95000023.accon)
	e3:SetCost(c95000023.accost)
	e3:SetOperation(c95000023.acop)
	c:RegisterEffect(e3)
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(93016201,0))
	e6:SetType(EFFECT_TYPE_QUICK_O)
	e6:SetCode(EVENT_SPSUMMON)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCondition(c95000023.accon)
	e6:SetTarget(c95000023.accost)
	e6:SetOperation(c95000023.acop)
	c:RegisterEffect(e6)
end
c95000023.mark=0
function c95000023.valcon(e,re,r,rp)
    return bit.band(r,REASON_EFFECT)~=0
end
function c95000023.accon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)<=1
end
function c95000023.cfilter(c,e,tp,eg,ep,ev,re,r,rp,chain)
	local te=c:GetActivateEffect()
	if not te or not c:IsType(TYPE_SPELL+TYPE_TRAP) or not c:IsAbleToGraveAsCost() then return false end
	local condition=te:GetCondition()
	local cost=te:GetCost()
	local target=te:GetTarget()
	if te:GetCode()==EVENT_CHAINING then
		if chain<=0 then return false end
		local te2=Duel.GetChainInfo(chain,CHAININFO_TRIGGERING_EFFECT)
		local tc=te2:GetHandler()
		local g=Group.FromCards(tc)
		local p=tc:GetControler()
		return (not condition or condition(e,tp,g,p,chain,te2,REASON_EFFECT,p)) and (not cost or cost(e,tp,g,p,chain,te2,REASON_EFFECT,p,0)) 
			and (not target or target(e,tp,g,p,chain,te2,REASON_EFFECT,p,0))
	elseif (te:GetCode()==EVENT_SPSUMMON and e:GetCode()==EVENT_SPSUMMON) or (e:GetCode()==EVENT_FREE_CHAIN and te:GetCode()~=EVENT_SPSUMMON) then
		return (not condition or condition(e,tp,eg,ep,ev,re,r,rp)) and (not cost or cost(e,tp,eg,ep,ev,re,r,rp,0)) 
			and (not target or target(e,tp,eg,ep,ev,re,r,rp,0))
	end
end
function c95000023.accost(e,tp,eg,ep,ev,re,r,rp,chk)
	local chain=Duel.GetCurrentChain()
	if chk==0 then return Duel.IsExistingMatchingCard(c95000023.cfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp,eg,ep,ev,re,r,rp,chain) end
	chain=chain-1
	Duel.RegisterFlagEffect(tp,511001666,RESET_CHAIN,0,1)
	Duel.RegisterFlagEffect(tp,95000027,RESET_CHAIN,0,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c95000023.cfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp,eg,ep,ev,re,r,rp,chain)
	Duel.SendtoGrave(g,REASON_COST)
	Duel.SetTargetCard(g:GetFirst())
end
function c95000023.acop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc then
		local te=tc:GetActivateEffect()
		if not te then return end
		e:SetCategory(te:GetCategory())
		e:SetProperty(te:GetProperty())
		local co=te:GetCost()
		local tg=te:GetTarget()
		local op=te:GetOperation()
		if te:GetCode()==EVENT_CHAINING then
			local chain=Duel.GetCurrentChain()-1
			local te2=Duel.GetChainInfo(chain,CHAININFO_TRIGGERING_EFFECT)
			local tc=te2:GetHandler()
			local g=Group.FromCards(tc)
			local p=tc:GetControler()
			if co then co(e,tp,g,p,chain,te2,REASON_EFFECT,p,1) end
			if tg then tg(e,tp,g,p,chain,te2,REASON_EFFECT,p,1) end
			if op then op(e,tp,g,p,chain,te2,REASON_EFFECT,p) end
		else
			if co then co(e,tp,eg,ep,ev,re,r,rp,1) end
			if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
			if op then op(e,tp,eg,ep,ev,re,r,rp) end
		end
	end
end
