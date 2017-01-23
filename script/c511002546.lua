--ブリザード・ファルコン
function c511002546.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(51102546)
	e1:SetTarget(c511002546.damtg)
	e1:SetOperation(c511002546.damop)
	c:RegisterEffect(e1)
	if not c511002546.global_check then
		c511002546.global_check=true
		--register
		local ge=Effect.CreateEffect(c)
		ge:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge:SetCode(EVENT_ADJUST)
		ge:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge:SetOperation(c511002546.regop)
		Duel.RegisterEffect(ge,0)
	end
end
function c511002546.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:GetFlagEffect(511002546)==0 then
			local e1=Effect.CreateEffect(c)	
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
			e1:SetCode(EVENT_CHAIN_SOLVED)
			e1:SetRange(LOCATION_MZONE)
			e1:SetLabel(tc:GetAttack())
			e1:SetOperation(c511002546.op)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(511002546,RESET_EVENT+0x1fe0000,0,1)
		end	
		tc=g:GetNext()
	end
end
function c511002546.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==c:GetAttack() then return end
	if e:GetLabel()<c:GetAttack() then
		local val=c:GetAttack()-e:GetLabel()
		if e:GetLabel()<=c:GetBaseAttack() and c:GetAttack()>c:GetBaseAttack() then
			Duel.RaiseSingleEvent(c,51102546,re,REASON_EFFECT,rp,tp,val)
		end
	end
	e:SetLabel(c:GetAttack())
end
function c511002546.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local atk=0
	if c:GetBaseAttack()>=c:GetAttack() then
		atk=c:GetBaseAttack()-c:GetAttack()
	else
		atk=c:GetAttack()-c:GetBaseAttack()
	end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(atk)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c511002546.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local atk=0
	if c:GetBaseAttack()>=c:GetAttack() then
		atk=c:GetBaseAttack()-c:GetAttack()
	else
		atk=c:GetAttack()-c:GetBaseAttack()
	end
	Duel.Damage(p,atk,REASON_EFFECT)
end
