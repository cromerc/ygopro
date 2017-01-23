--Numeron Spell Revision
function c511001665.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511001665.condition)
	e1:SetCost(c511001665.cost)
	e1:SetTarget(c511001665.target)
	e1:SetOperation(c511001665.activate)
	c:RegisterEffect(e1)
end
function c511001665.cfilter(c)
	return c:GetSequence()<5
end
function c511001665.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and re:IsActiveType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE) 
		and not Duel.IsExistingMatchingCard(c511001665.cfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
end
function c511001665.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsChainNegatable(ev) and Duel.IsChainDisablable(ev) end
	--Duel.NegateActivation(ev)
	--Duel.NegateEffect(ev)
end
function c511001665.filter(c,tp,eg,ep,ev,re,r,rp)
	local te=c:GetActivateEffect()
	if not te then return false end
	local condition=te:GetCondition()
	local cost=te:GetCost()
	local target=te:GetTarget()
	return (Duel.GetLocationCount(1-tp,LOCATION_SZONE)>0 or c:IsType(TYPE_FIELD)) and c:IsType(TYPE_SPELL) 
		and (not condition or condition(te,1-tp,eg,ep,ev,re,r,rp)) and (not cost or cost(te,1-tp,eg,ep,ev,re,r,rp,0))
		and (not target or target(te,1-tp,eg,ep,ev,re,r,rp,0))
end
function c511001665.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001665.filter,tp,0,LOCATION_DECK,1,nil,tp,eg,ep,ev,re,r,rp) end
	Duel.NegateActivation(ev)
	Duel.NegateEffect(ev)
end
function c511001665.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511001665.filter,tp,0,LOCATION_DECK,nil,tp,eg,ep,ev,re,r,rp)
	if sg:GetCount()<=0 then return end
	Duel.ConfirmCards(tp,sg)
	local g=sg:Select(tp,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
        local tpe=tc:GetType()
		local te=tc:GetActivateEffect()
		local opt=0
		if te then
    	    local con=te:GetCondition()
			local co=te:GetCost()
			local tg=te:GetTarget()
			local op=te:GetOperation()
			Duel.ClearTargetCard()
			e:SetCategory(te:GetCategory())
			e:SetProperty(te:GetProperty())
			if bit.band(tpe,TYPE_FIELD)~=0 then
				local of=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
				if of and Duel.Destroy(of,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
			end
			Duel.MoveToField(tc,tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.Hint(HINT_CARD,0,tc:GetCode())
			tc:CreateEffectRelation(te)
			if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
				tc:CancelToGrave(false)
			end
			if co then co(te,1-tp,eg,ep,ev,re,r,rp,1) end
			if tg then tg(te,1-tp,eg,ep,ev,re,r,rp,1) end
			local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
			if g then
				local etc=g:GetFirst()
				while etc do
					etc:CreateEffectRelation(te)
					etc=g:GetNext()
				end
			end
			Duel.BreakEffect()
			if op then op(te,1-tp,eg,ep,ev,re,r,rp) end
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
end
