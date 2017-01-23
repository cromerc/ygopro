--Charge
function c511001805.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001805.target)
	e1:SetOperation(c511001805.activate)
	c:RegisterEffect(e1)
end
function c511001805.filter(c)
	return c:IsFaceup() and c:IsCode(50400231)
end
function c511001805.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001805.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c511001805.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511001805.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(2000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
