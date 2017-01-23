--天馬之翼
function c100000526.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000526.target)
	e1:SetOperation(c100000526.activate)
	c:RegisterEffect(e1)
end
function c100000526.filter(c,e,tp)
	return c:GetCode()==100000533 or c:GetCode()==100000534 or c:GetCode()==100000537 or c:GetCode()==100000538
end
function c100000526.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,100000527) end
end
function c100000526.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(c100000526.filter,tp,LOCATION_MZONE,0,nil)
	local tc=dg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		--
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_DAMAGE_CALCULATING)
		e3:SetCondition(c100000526.atkcon)
		e3:SetOperation(c100000526.atkop)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
		tc=dg:GetNext()
	end
end
function c100000526.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)~=0
		and e:GetHandler():GetEffectCount(EFFECT_DIRECT_ATTACK)==1
end
function c100000526.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	e1:SetValue(c:GetAttack()/2)
	c:RegisterEffect(e1)
end