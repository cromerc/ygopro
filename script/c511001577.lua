--Number Spell Caster
function c511001577.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCost(c511001577.cost)
	e1:SetTarget(c511001577.target)
	e1:SetOperation(c511001577.operation)
	c:RegisterEffect(e1)
end
function c511001577.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x48) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x48)
	Duel.Release(g,REASON_COST)
end
function c511001577.filter(c,tp,eg,ep,ev,re,r,rp)
	local te=c:GetActivateEffect()
	if not te then return false end
	local condition=te:GetCondition()
	local cost=te:GetCost()
	local target=te:GetTarget()
	return c:IsType(TYPE_SPELL) and c:IsType(TYPE_CONTINUOUS) and (not condition or condition(te,tp,eg,ep,ev,re,r,rp)) 
		and (not cost or cost(te,tp,eg,ep,ev,re,r,rp,0))
		and (not target or target(te,tp,eg,ep,ev,re,r,rp,0))
end
function c511001577.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=0
	if e:GetHandler():IsLocation(LOCATION_HAND) then ct=ct+1 end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>ct
		and Duel.IsExistingMatchingCard(c511001577.filter,tp,LOCATION_DECK,0,1,nil,tp,eg,ep,ev,re,r,rp) end
end
function c511001577.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local sg=Duel.GetMatchingGroup(c511001577.filter,tp,LOCATION_DECK,0,nil,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
	local g=sg:Select(tp,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
        local tpe=tc:GetType()
		local te=tc:GetActivateEffect()
		if te then
    	    local con=te:GetCondition()
			local co=te:GetCost()
			local tg=te:GetTarget()
			local op=te:GetOperation()
			Duel.ClearTargetCard()
			e:SetCategory(te:GetCategory())
			e:SetProperty(te:GetProperty())
			if bit.band(tpe,TYPE_FIELD)~=0 then
				local of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
				if of and Duel.Destroy(of,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
			end
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.Hint(HINT_CARD,0,tc:GetCode())
			tc:CreateEffectRelation(te)
			if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
				tc:CancelToGrave(false)
			end
			if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
			if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
			local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
			if g then
				local etc=g:GetFirst()
				while etc do
					etc:CreateEffectRelation(te)
					etc=g:GetNext()
				end
			end
			Duel.BreakEffect()
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
end
