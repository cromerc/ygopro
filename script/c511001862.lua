--Power Exchange
function c511001862.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511001862.condition)
	e1:SetTarget(c511001862.target)
	e1:SetOperation(c511001862.operation)
	c:RegisterEffect(e1)
end
function c511001862.condition(e,tp,eg,ep,ev,re,r,rp)
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	e:SetLabel(cv)
	if ex and (cp==tp or cp==PLAYER_ALL) then return true end
	ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
	e:SetLabel(cv)
	return ex and (cp==tp or cp==PLAYER_ALL) and Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_RECOVER)
end
function c511001862.filter(c,atk)
	return c:IsFaceup() and c:GetAttack()>=atk
end
function c511001862.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local cid=e:GetLabel()
	if chk==0 then return Duel.IsExistingMatchingCard(c511001862.filter,tp,LOCATION_MZONE,0,1,nil,cid) end
end
function c511001862.operation(e,tp,eg,ep,ev,re,r,rp)
	local cid=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,c511001862.filter,tp,LOCATION_MZONE,0,1,1,nil,cid)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-cid)
		if tc:RegisterEffect(e1) then
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_FIELD)
			e2:SetCode(EFFECT_CHANGE_DAMAGE)
			e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e2:SetTargetRange(1,0)
			e2:SetLabel(cid)
			e2:SetValue(c511001862.damcon)
			e2:SetReset(RESET_CHAIN)
			Duel.RegisterEffect(e2,tp)
		end
	end
end
function c511001862.damcon(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return val end
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	return 0
end
