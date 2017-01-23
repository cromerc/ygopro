--Vow of Tribe
function c511002479.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)	
	e1:SetCondition(c511002479.condition)
	e1:SetOperation(c511002479.activate)
	c:RegisterEffect(e1)
end
function c511002479.cfilter(c)
	local p=c:GetControler()
	return c:IsFaceup() and Duel.IsExistingMatchingCard(c511002479.filter,p,0,LOCATION_MZONE,1,nil,c:GetCode())
end
function c511002479.filter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c511002479.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511002479.cfilter,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.IsExistingMatchingCard(c511002479.cfilter,tp,0,LOCATION_MZONE,1,nil)
end
function c511002479.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002479.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
