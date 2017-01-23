--Full Moon Mirror
function c511000919.initial_effect(c)
	c:EnableCounterPermit(0x99)
	c:SetCounterLimit(0x99,10)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--add counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_DESTROY)
	e2:SetCondition(c511000919.ctcon)
	e2:SetOperation(c511000919.ctop)
	c:RegisterEffect(e2)
	--activate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000919,0))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511000919.accon)
	e3:SetCost(c511000919.accost)
	e3:SetTarget(c511000919.actg)
	e3:SetOperation(c511000919.acop)
	c:RegisterEffect(e3)
end
function c511000919.ctfilter(c)
	return c:IsFaceup() and c:IsLocation(LOCATION_MZONE)
end
function c511000919.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000919.ctfilter,1,nil)
end
function c511000919.ctop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x99,1)
end
function c511000919.accon(e)
	return e:GetHandler():GetCounter(0x99)==10
end
function c511000919.accost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511000919.filter(c,tp)
	return c:IsCode(100000080) and c:GetActivateEffect():IsActivatable(tp)
end
function c511000919.actg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000919.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,tp) end
end
function c511000919.acop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
	local tc=Duel.SelectMatchingCard(tp,c511000919.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,tp):GetFirst()
	if tc then
		if bit.band(tpe,TYPE_FIELD)~=0 then
			local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
			if Duel.GetFlagEffect(tp,62765383)>0 then
				if fc then Duel.Destroy(fc,REASON_RULE) end
				of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
				if fc and Duel.Destroy(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
			else
				Duel.GetFieldCard(tp,LOCATION_SZONE,5)
				if fc and Duel.SendtoGrave(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
			end
		end
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.RaiseEvent(tc,EVENT_CHAIN_SOLVED,tc:GetActivateEffect(),0,tp,tp,Duel.GetCurrentChain())
	end
end
