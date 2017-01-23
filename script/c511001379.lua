--Power Bombard
function c511001379.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(511001265)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511001379.damcon)
	e1:SetTarget(c511001379.damtg)
	e1:SetOperation(c511001379.damop)
	c:RegisterEffect(e1)
	if not c511001379.global_check then
		c511001379.global_check=true
		--register
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_ADJUST)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetOperation(c511001379.operation)
		Duel.RegisterEffect(e2,0)
	end
end
function c511001379.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local g=Duel.GetMatchingGroup(nil,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:IsFaceup() and tc:GetFlagEffect(511001265)==0 then
			local e1=Effect.CreateEffect(c)	
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
			e1:SetCode(EVENT_CHAIN_SOLVED)
			e1:SetRange(LOCATION_MZONE)
			e1:SetLabel(tc:GetAttack())
			e1:SetOperation(c511001379.op)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(511001265,RESET_EVENT+0x1fe0000,0,1)
		end	
		tc=g:GetNext()
	end		
end
function c511001379.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==c:GetAttack() then return end
	local val=0
	if e:GetLabel()>c:GetAttack() then
		val=e:GetLabel()-c:GetAttack()
	else
		val=c:GetAttack()-e:GetLabel()
	end
	Duel.RaiseEvent(c,511001265,re,REASON_EFFECT,rp,tp,val)
	e:SetLabel(c:GetAttack())
end
function c511001379.damcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return ec:IsControler(tp) and ec:IsCode(511001378) and ev>0
end
function c511001379.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1800)
end
function c511001379.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.Destroy(e:GetHandler(),REASON_EFFECT)~=0 then
		Duel.Damage(1-tp,1800,REASON_EFFECT)
	end
end
