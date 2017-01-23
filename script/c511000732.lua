--Power Connection
function c511000732.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000732.target)
	e1:SetOperation(c511000732.operation)
	c:RegisterEffect(e1)
end
function c511000732.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000732.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c511000732.filter1(c)
	local ct=Duel.GetMatchingGroupCount(c511000732.filter2,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,c,c:GetRace())
	return c:IsFaceup() and ct>0
end
function c511000732.filter2(c,race)
	return c:IsFaceup() and c:GetRace()==race
end
function c511000732.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511000732.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local ct=Duel.GetMatchingGroupCount(c511000732.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,tc,tc:GetRace())*500
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(ct)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
