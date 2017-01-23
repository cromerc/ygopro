--Spell Absorption (Anime)
function c511000377.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(511001762)
	e1:SetCondition(c511000377.condition)
	e1:SetTarget(c511000377.target)
	e1:SetOperation(c511000377.activate)
	c:RegisterEffect(e1)
	if not c511000377.global_check then
		c511000377.global_check=true
		--register
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_ADJUST)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetOperation(c511000377.operation)
		Duel.RegisterEffect(e2,0)
	end
end
function c511000377.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local g=Duel.GetMatchingGroup(nil,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:GetFlagEffect(511001762)==0 then
			local e1=Effect.CreateEffect(c)	
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
			e1:SetCode(EVENT_CHAIN_SOLVED)
			e1:SetRange(LOCATION_MZONE)
			e1:SetLabel(tc:GetAttack())
			e1:SetOperation(c511000377.op)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(511001762,RESET_EVENT+0x1fe0000,0,1) 	
		end	
		tc=g:GetNext()
	end
end
function c511000377.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==c:GetAttack() then return end
	local val=0
	if c:GetAttack()>e:GetLabel() then
		val=c:GetAttack()-e:GetLabel()
		Duel.RaiseEvent(c,511001762,re,REASON_EFFECT,rp,tp,val)
	end
	e:SetLabel(c:GetAttack())
end
function c511000377.condition(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return ec:IsControler(1-tp) and ev>0 and re and re:IsActiveType(TYPE_SPELL)
end
function c511000377.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ec=eg:GetFirst()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	ec:CreateEffectRelation(e)
end
function c511000377.activate(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	local tc=Duel.GetFirstTarget()
	if ec and ec:IsRelateToEffect(e) and ec:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-ev)
		ec:RegisterEffect(e1)
		if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			e2:SetValue(ev)
			tc:RegisterEffect(e2)
		end
	end
end
