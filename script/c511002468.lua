--Infection Fly
function c511002468.initial_effect(c)
	--level
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98154550,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511002468.target)
	e1:SetOperation(c511002468.operation)
	c:RegisterEffect(e1)
end
function c511002468.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c511002468.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002468.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c511002468.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002468.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(tc:GetLevel()*2)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
