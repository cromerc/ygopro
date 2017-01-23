--Kaiser Sea Horse (DM)
--Scripted by edo9300
function c511000575.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c511000575.condition)
	c:RegisterEffect(e1)
	--decrease tribute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DECREASE_TRIBUTE)
	e2:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e2:SetCondition(c511000575.con)
	e2:SetTargetRange(LOCATION_HAND,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_LIGHT))
	e2:SetValue(0x10001)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_DECREASE_TRIBUTE_SET)
	c:RegisterEffect(e3)
	if not c511000575.global_check then
		c511000575.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c511000575.chk)
		Duel.RegisterEffect(ge1,0)
	end
end
c511000575.dm=true
function c511000575.chk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,300)
	Duel.CreateToken(1-tp,300)
end
function c511000575.condition(e,c)
	return c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c511000575.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(300)>0
end	
