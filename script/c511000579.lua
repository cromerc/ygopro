--Aracno-Cannibalism
function c511000579.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000579.cost)
	e1:SetTarget(c511000579.target)
	e1:SetOperation(c511000579.activate)
	c:RegisterEffect(e1)
end
function c511000579.cfilter(c,tp)
	return c:IsFaceup() and c:GetLevel()>0 and Duel.IsExistingMatchingCard(c511000579.filter,tp,LOCATION_MZONE,0,1,c)
end
function c511000579.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c511000579.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511000579.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.CheckReleaseGroup(tp,c511000579.cfilter,1,nil,tp) end
	local rg=Duel.SelectReleaseGroup(tp,c511000579.cfilter,1,1,nil,tp)
	local lv=rg:GetFirst():GetLevel()
	Duel.Release(rg,REASON_COST)
	Duel.SetTargetParam(lv)
end
function c511000579.activate(e,tp,eg,ep,ev,re,r,rp)
	local lv=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local g=Duel.GetMatchingGroup(c511000579.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
