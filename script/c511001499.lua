--Take One Chance
function c511001499.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001499.target)
	e1:SetOperation(c511001499.activate)
	c:RegisterEffect(e1)
end
function c511001499.filter(c,tp,eg,ep,ev,re,r,rp)
	local te=c:GetActivateEffect()
	if not te then return false end
	local condition=te:GetCondition()
	local cost=te:GetCost()
	local target=te:GetTarget()
	return (not condition or condition(te,tp,eg,ep,ev,re,r,rp)) and (not cost or cost(te,tp,eg,ep,ev,re,r,rp,0))
		and (not target or target(te,tp,eg,ep,ev,re,r,rp,0))
end
function c511001499.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001499.filter,tp,LOCATION_GRAVE,0,1,nil,tp,eg,ep,ev,re,r,rp) 
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c511001499.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local sg=Duel.GetMatchingGroup(nil,tp,LOCATION_GRAVE,0,nil)
	local g=sg:RandomSelect(tp,1)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
        local tpe=tc:GetType()
		local te=tc:GetActivateEffect()
		if not te then return end
		local con=te:GetCondition()
		local co=te:GetCost()
		local tg=te:GetTarget()
		local op=te:GetOperation()
		if (not condition or condition(te,tp,eg,ep,ev,re,r,rp)) and (not cost or cost(te,tp,eg,ep,ev,re,r,rp,0))
			and (not target or target(te,tp,eg,ep,ev,re,r,rp,0)) then
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
		else
			Duel.ConfirmCards(1-tp,g)
			Duel.ConfirmCards(tp,g)
		end
	end
end
