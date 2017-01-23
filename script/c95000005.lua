--Zero
function c95000005.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95000005.target)
	e1:SetOperation(c95000005.activate)
	c:RegisterEffect(e1)
end
c95000005.mark=0
function c95000005.filter(c)
   return c:IsFacedown() and c:IsCode(95000004)
end
function c95000005.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c95000005.filter,tp,LOCATION_SZONE,0,1,nil) end 
	Duel.Hint(HINT_SELECT,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c95000005.filter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.SetChainLimit(c95000005.climit)
end
function c95000005.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and e:GetHandler():IsRelateToEffect(e) then 
	    tc:RegisterFlagEffect(95000005,RESET_PHASE+PHASE_END+RESET_EVENT+0x1fe0000,0,1)
	    if tc:IsCode(95000004) then
		local te=tc:GetActivateEffect()
		local tep=tc:GetControler()
		if not te then
			Duel.Destroy(tc,REASON_EFFECT)
		else
			local condition=te:GetCondition()
			local cost=te:GetCost()
			local target=te:GetTarget()
			local operation=te:GetOperation()
			if te:GetCode()==EVENT_FREE_CHAIN and not tc:IsStatus(STATUS_SET_TURN)
				and (not condition or condition(te,tep,eg,ep,ev,re,r,rp))
				and (not cost or cost(te,tep,eg,ep,ev,re,r,rp,0))
				and (not target or target(te,tep,eg,ep,ev,re,r,rp,0)) then
				Duel.ClearTargetCard()
				e:SetProperty(te:GetProperty())
				Duel.ChangePosition(tc,POS_FACEUP)
				Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
				if tc:GetType()==TYPE_TRAP then
					tc:CancelToGrave(false)
				end
				tc:CreateEffectRelation(te)
				if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
				if target then target(te,tep,eg,ep,ev,re,r,rp,1) end
				local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
				local tg=g:GetFirst()
				while tg do
					tg:CreateEffectRelation(te)
					tg=g:GetNext()
				end
				if operation then operation(te,tep,eg,ep,ev,re,r,rp) end
				tc:ReleaseEffectRelation(te)
				tg=g:GetFirst()
				while tg do
					tg:ReleaseEffectRelation(te)
					tg=g:GetNext()
				end
			end
		end
	end
	end
end
function c95000005.climit(e,lp,tp)
	return lp==tp or not e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
