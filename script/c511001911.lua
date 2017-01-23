--Alert
function c511001911.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001911.target)
	e1:SetOperation(c511001911.activate)
	c:RegisterEffect(e1)
end
function c511001911.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsType(TYPE_CONTINUOUS) and c:IsFacedown() 
		and c:CheckActivateEffect(false,false,false)~=nil
end
function c511001911.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001911.filter,tp,LOCATION_SZONE,0,1,nil) end
end
function c511001911.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.SelectMatchingCard(tp,c511001911.filter,tp,LOCATION_SZONE,0,1,1,nil)
	local tc=sg:GetFirst()
	if tc then
		Duel.HintSelection(sg)
		local tpe=tc:GetType()
		local te=tc:GetActivateEffect()
		local tg=te:GetTarget()
		local co=te:GetCost()
		local op=te:GetOperation()
		e:SetCategory(te:GetCategory())
		e:SetProperty(te:GetProperty())
		Duel.ClearTargetCard()
		Duel.ChangePosition(tc,POS_FACEUP)
		Duel.Hint(HINT_CARD,0,tc:GetCode())
		tc:CreateEffectRelation(te)
		if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
			tc:CancelToGrave(false)
		end
		if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
		if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
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
