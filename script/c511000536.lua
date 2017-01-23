--魔水晶
function c511000536.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000536.condition)
	e1:SetOperation(c511000536.activate)
	c:RegisterEffect(e1)
	if not c511000536.global_check then
		c511000536.global_check=true
		--register
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_ADJUST)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetOperation(c511000536.operation)
		Duel.RegisterEffect(e2,0)
	end
end
function c511000536.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local g=Duel.GetMatchingGroup(nil,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:IsFaceup() and tc:GetFlagEffect(511000536)==0 then
			local e1=Effect.CreateEffect(c)	
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
			e1:SetCode(EVENT_CHAIN_SOLVED)
			e1:SetRange(LOCATION_MZONE)
			e1:SetLabel(tc:GetAttack())
			e1:SetOperation(c511000536.op)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(511000536,RESET_EVENT+0x1fe0000,0,1) 	
		end	
		tc=g:GetNext()
	end		
end
function c511000536.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==c:GetAttack() then return end
	local val=c:GetAttack()-e:GetLabel()
	Duel.RaiseEvent(c,511000536,re,REASON_EFFECT,rp,tp,val)
	e:SetLabel(c:GetAttack())
end
function c511000536.cfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c511000536.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000536.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511000536.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(511000536)
	e1:SetCondition(c511000536.atkcon)
	e1:SetOperation(c511000536.atkop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511000536.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetCount()==1 and ev~=0 and eg:GetFirst():IsControler(1-tp)
end
function c511000536.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(ev)
	tc:RegisterEffect(e1)
end
