--遺言の札
function c513000037.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(511001265)
	e1:SetCondition(c513000037.condition)
	e1:SetTarget(c513000037.target)
	e1:SetOperation(c513000037.activate)
	c:RegisterEffect(e1)
	if not c513000037.global_check then
		c513000037.global_check=true
		--register
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_ADJUST)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetOperation(c513000037.operation)
		Duel.RegisterEffect(e2,0)
	end
end
function c513000037.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local g=Duel.GetMatchingGroup(nil,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:GetFlagEffect(511001265)==0 then
			local e1=Effect.CreateEffect(c)	
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
			e1:SetCode(EVENT_CHAIN_SOLVED)
			e1:SetRange(LOCATION_MZONE)
			e1:SetLabel(tc:GetAttack())
			e1:SetOperation(c513000037.op)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(511001265,RESET_EVENT+0x1fe0000,0,1) 	
		end	
		tc=g:GetNext()
	end
end
function c513000037.op(e,tp,eg,ep,ev,re,r,rp)
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
function c513000037.condition(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return ec:IsControler(tp) and ev>0
end
function c513000037.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if chk==0 then return hg:GetCount()<5 and Duel.IsPlayerCanDraw(tp,5-hg:GetCount()) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(5-hg:GetCount())
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,5-hg:GetCount())
end
function c513000037.activate(e,tp,eg,ep,ev,re,r,rp)
	local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if hg:GetCount()<5 then
		Duel.Draw(tp,5-hg:GetCount(),REASON_EFFECT)
	end
end
