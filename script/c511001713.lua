--Performapal Raingoat
function c511001713.initial_effect(c)
	--Negate Damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVING)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511001713.con)
	e1:SetOperation(c511001713.op)
	c:RegisterEffect(e1)
end
function c511001713.con(e,tp,eg,ep,ev,re,r,rp)
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if ex and (cp==tp or cp==PLAYER_ALL) then return true end
	ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
	return ex and (cp==tp or cp==PLAYER_ALL) and Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_RECOVER)
end
function c511001713.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsAbleToGraveAsCost() and Duel.SelectYesNo(tp,aux.Stringid(2407147,0)) 
		and Duel.SendtoGrave(c,REASON_COST+REASON_REPLACE)>0 then
		local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CHANGE_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,0)
		e1:SetLabel(cid)
		e1:SetValue(c511001713.refcon)
		e1:SetReset(RESET_CHAIN)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511001713.refcon(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return end
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	if cid==e:GetLabel() then return 0
	else return val end
end
