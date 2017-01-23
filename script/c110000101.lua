--オレイカルコス・トリトス
function c110000101.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c110000101.atcon)
	c:RegisterEffect(e1)
	--immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetValue(c110000101.efilter)
	c:RegisterEffect(e3)
	--selfdes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_ADJUST)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c110000101.sdcon2)
	e4:SetOperation(c110000101.sdop)
	c:RegisterEffect(e4)
end
function c110000101.sdcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(110000101)==0
end
function c110000101.sdop(e,tp,eg,ep,ev,re,r,rp)	
	e:GetHandler():CopyEffect(48179391,RESET_EVENT+0x1fe0000)
	e:GetHandler():CopyEffect(110000100,RESET_EVENT+0x1fe0000)
	e:GetHandler():RegisterFlagEffect(110000101,RESET_EVENT+0x1fe0000,0,1)
end
function c110000101.atcon(e)
	local tc=Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)	
	return tc~=nil and tc:IsFaceup() and tc:GetCode()==110000100
end
function c110000101.sdcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(110000101)==0
end
function c110000101.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP) and te:GetHandler():GetControler()~=e:GetHandler():GetControler()
end
