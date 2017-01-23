--ライトニング·ボルテックス
function c511001184.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001184.target)
	e1:SetOperation(c511001184.activate)
	c:RegisterEffect(e1)
end
function c511001184.filter(c)
	return c:IsFaceup() and not c:IsAttribute(ATTRIBUTE_WATER)
end
function c511001184.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001184.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c511001184.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511001184.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=sg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e1:SetValue(ATTRIBUTE_WATER)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=sg:GetNext()
	end
end
