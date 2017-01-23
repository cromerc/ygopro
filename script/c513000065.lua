--神の進化
function c513000065.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetTarget(c513000065.target)
	e1:SetOperation(c513000065.activate)
	c:RegisterEffect(e1)
end
function c513000065.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DEVINE)
end
function c513000065.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c513000065.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c513000065.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c513000065.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(513000065)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_IMMUNE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(c513000065.efilter)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_ADJUST)
		e3:SetCountLimit(1)
		e3:SetRange(LOCATION_MZONE)
		e3:SetOperation(c513000065.atkup)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3)
		tc=g:GetNext()
	end
end
function c513000065.efilter(e,te)
	return te:GetOwner()~=e:GetOwner() and te:GetOwner()~=e:GetHandler()
end
function c513000065.atkup(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--Atk/Def up
	local e2=Effect.CreateEffect(e:GetOwner())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(1000)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
