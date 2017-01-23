--Greed Quasar (anime)
function c511009013.initial_effect(c)
	--base attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c511009013.atkval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_BASE_DEFENSE)
	c:RegisterEffect(e2)

	--Add counter
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e6:SetCode(EVENT_LEAVE_FIELD)
	e6:SetRange(LOCATION_MZONE)
	e6:SetOperation(c511009013.addop2)
	c:RegisterEffect(e6)
end
function c511009013.atkval(e,c)
	return c:GetCounter(0x1109)*300
end
function c511009013.addop2(e,tp,eg,ep,ev,re,r,rp)
	local count=0
	local c=eg:GetFirst()
	while c~=nil do
		if c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsReason(REASON_DESTROY) and c:GetReasonCard()==e:GetHandler() then
			count=count+c:GetCounter(0x1109)
		end
		c=eg:GetNext()
	end
	if count>0 then
		e:GetHandler():AddCounter(0x1109,count)
	end
end
