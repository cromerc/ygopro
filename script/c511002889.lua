--Hand Block
function c511002889.initial_effect(c)
	--reflect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511002889.condition)
	e1:SetOperation(c511002889.operation)
	c:RegisterEffect(e1)
end
c511002889.collection={
	[28003512]=true;[52800428]=true;[62793020]=true;[68535320]=true;[95929069]=true;
	[22530212]=true;[21414674]=true;
}
function c511002889.cfilter(c)
	return c:IsFaceup() and c511002889.collection[c:GetCode()]
end
function c511002889.condition(e,tp,eg,ep,ev,re,r,rp)
	return aux.damcon1(e,tp,eg,ep,ev,re,r,rp) 
		and Duel.IsExistingMatchingCard(c511002889.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511002889.operation(e,tp,eg,ep,ev,re,r,rp)
	local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetLabel(cid)
	e1:SetValue(c511002889.refcon)
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
end
function c511002889.refcon(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return end
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	if cid==e:GetLabel() then return 0 end
	return val
end
