--Tsukumo Slash
function c511002470.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(511001762)
	e1:SetCondition(c511002470.condition)
	e1:SetTarget(c511002470.target)
	e1:SetOperation(c511002470.activate)
	c:RegisterEffect(e1)
	if not c511002470.global_check then
		c511002470.global_check=true
		--register
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_ADJUST)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetOperation(c511002470.operation)
		Duel.RegisterEffect(e2,0)
	end
end
function c511002470.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local g=Duel.GetMatchingGroup(nil,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:GetFlagEffect(511001762)==0 then
			local e1=Effect.CreateEffect(c)	
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
			e1:SetCode(EVENT_CHAIN_SOLVED)
			e1:SetRange(LOCATION_MZONE)
			e1:SetLabel(tc:GetAttack())
			e1:SetOperation(c511002470.op)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(511001762,RESET_EVENT+0x1fe0000,0,1) 	
		end	
		tc=g:GetNext()
	end
end
function c511002470.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==c:GetAttack() then return end
	local val=0
	if c:GetAttack()>e:GetLabel() then
		val=c:GetAttack()-e:GetLabel()
		Duel.RaiseEvent(c,511001762,re,REASON_EFFECT,rp,tp,val)
	end
	e:SetLabel(c:GetAttack())
end
function c511002470.condition(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return Duel.GetLP(tp)<=100 and Duel.GetLP(1-tp)<=100 and Duel.GetLP(tp)~=Duel.GetLP(1-tp) 
		and ec:IsControler(1-tp) and ev>0
end
function c511002470.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
end
function c511002470.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		if Duel.GetLP(tp)>100 or Duel.GetLP(1-tp)>100 or Duel.GetLP(tp)==Duel.GetLP(1-tp) then return end
		local val=0
		if Duel.GetLP(tp)>Duel.GetLP(1-tp) then
			val=Duel.GetLP(tp)-Duel.GetLP(1-tp)
		else
			val=Duel.GetLP(1-tp)-Duel.GetLP(tp)
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(val*100)
		tc:RegisterEffect(e1)
	end
end
