--coded by Lyris
--Clean Barrier - Clear Force
function c511007014.initial_effect(c)
	--When an opponent's monster declares an attack: The ATK of all face-up monsters your opponent currently controls becomes their original ATK, [Number 107: Galaxy-Eyes Tachyon Dragon] also negate any card effects that would change the ATK of a monster(s) your opponent controls [Distortion Crystal]. These changes last until the end of the Battle Phase.
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511007014.condition)
	e1:SetOperation(c511007014.activate)
	c:RegisterEffect(e1)
	if not c511007014.global_check then
		c511007014.global_check=true
		--Check for ATK changing effects
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_ADJUST)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetOperation(c511007014.operation)
		Duel.RegisterEffect(e2,0)
	end
end
function c511007014.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()  
	local g=Duel.GetMatchingGroup(nil,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:IsFaceup() and tc:GetFlagEffect(511007014)==0 then
			local e1=Effect.CreateEffect(c) 
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
			e1:SetCode(EVENT_CHAIN_SOLVED)
			e1:SetRange(LOCATION_MZONE)
			e1:SetLabel(tc:GetAttack())
			e1:SetOperation(c511007014.op)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(511007014,RESET_EVENT+0x1fe0000,0,1)  
		end 
		tc=g:GetNext()
	end	 
end
function c511007014.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==c:GetAttack() then return end
	local val=c:GetAttack()-e:GetLabel()
	Duel.RaiseEvent(c,511007014,re,REASON_EFFECT,rp,tp,val)
	e:SetLabel(c:GetAttack())
end
function c511007014.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511007014.filter(c)
	return c:IsFaceup() and c:GetAttack()~=c:GetBaseAttack()
end
function c511007014.activate(e,tp,eg,ep,ev,re,r,rp)
	--[[local e0=Effect.CreateEffect(e:GetHandler())
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_DISABLE)
	e0:SetTargetRange(0,LOCATION_MZONE)
	Duel.RegisterEffect(e0,tp)]]
	local e0=Effect.CreateEffect(e:GetHandler())
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(511007014)
	e0:SetCondition(c511007014.atkcon)
	e0:SetOperation(c511007014.atkop)
	e0:SetReset(RESET_PHASE+PHASE_BATTLE)
	Duel.RegisterEffect(e0,tp)
	local g=Duel.GetMatchingGroup(c511007014.filter,tp,0,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:GetAttack()~=tc:GetBaseAttack() then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetValue(tc:GetBaseAttack())
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
			tc:RegisterEffect(e1)
		end
		tc=g:GetNext()
	end
end
--[[function c511007014.dfilter(c)
	return c:IsHasEffect(EFFECT_UPDATE_ATTACK) or c:IsHasEffect(EFFECT_SET_ATTACK) or c:IsHasEffect(EFFECT_SET_ATTACK_FINAL) or c:IsHasEffect(EFFECT_SET_BASE_ATTACK)
end]]
function c511007014.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsControler,1,nil,1-tp) and ev~=0
end
function c511007014.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	e1:SetValue(tc:GetAttack()-ev)
	tc:RegisterEffect(e1)
end
